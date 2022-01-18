/// @description 




if global.phase = 0{// Initialization of all variables, obj_birds and giving them neural networks
	
	//create the birds
	ds_list_clear(birds_all_id);
	for(var i=0;i<birds_per_generation;i+=1){
		
		var inst = instance_create_depth(birds_start_x, birds_start_y, -2, obj_bird);
		
		//initialize our neural network
		inst.NN = scr_NN_initialize(num_inputs, num_hidden_layers, num_neurons, num_outputs);
	
	
		ds_list_add(birds_all_id, inst);	//add to the list of all ids of birds
	}
	
	//add all frozen birds
	ds_list_clear(birds_frozen_all_id);
	for(var i=0;i<birds_num_frozen;i+=1){
		
		var inst = instance_create_depth(32, birds_start_y+100*i, -2, obj_frozen_bird);
		
		//initialize our neural network
		inst.NN = scr_NN_initialize(num_inputs, num_hidden_layers, num_neurons, num_outputs);
	
		ds_list_add(birds_frozen_all_id, inst);	//add to the list of all ids of birds
	}
	
	
	//create initial lvl (initial pipe)
	for(var i=0;i<2;i+=1){
		inst = instance_create_depth(pipe_start_x-i*pipe_hor_diff, 	irandom_range(pipe_start_y_min, pipe_start_y_max),-2, obj_pipe_dual);
	}
	
	
	//move on to playing phase
	global.phase = 1;
	
}
else if global.phase = 1{	// In this phase, the birds are moving. It ends when all the birds are dead
	
	
	//find the next pipe (which the birds use for their inputs)
	global.next_pipe = -1;
	var most_right_pipe_id = -1;
	var diff_x_cur = room_width*2;
	for(i=0;i<instance_number(obj_pipe_dual);i+=1){
		var inst = instance_find(obj_pipe_dual,i);
		if (inst.x>birds_start_x-sprite_get_width(spr_pipe)/2){
			var diff_x = inst.x-birds_start_x;
			if diff_x<diff_x_cur{
				global.next_pipe = inst;
				diff_x_cur = diff_x;
			}
		}
		if most_right_pipe_id=-1 or inst.x>most_right_pipe_id.x{
			most_right_pipe_id = inst;	
		}
	}
	
	
	
	//create new pipes
	if most_right_pipe_id.x< pipe_start_x - pipe_hor_diff{
		inst = instance_create_depth(pipe_start_x, irandom_range(pipe_start_y_min, pipe_start_y_max),-5, obj_pipe_dual);
		inst.pipe_diff = pipe_ver_diff;
	}
	
	//move pipes
	for(i=0;i<instance_number(obj_pipe_dual);i+=1){
		inst = instance_find(obj_pipe_dual,i);
		inst.x += pipe_v;
		
		// Check if we scored the pipe or not
		if inst.scored = false and inst.x<birds_start_x{
			inst.scored = true;
			highscore_cur += 1;
		}
	}
	
	
	//move dead birds
	num_dead_birds = 0;
	for(var i=0;i<ds_list_size(birds_all_id);i+=1){
		inst = ds_list_find_value(birds_all_id,i);
		if inst.todestroy = true{
			inst.x += pipe_v;
			num_dead_birds += 1;
		}
	}

	//check if all birds are dead
	if num_dead_birds = instance_number(obj_bird){
		global.phase = 3;	
	}
	
	
	
}
else if global.phase = 3{// This is where we rank all of the birds, copy neural networks and mutate


	//get all fitness scores from birds and frozen birds.
	all_scores = ds_list_create();
	all_ids = ds_list_create();
	for(i=0;i<instance_number(obj_bird);i+=1){
		inst = instance_find(obj_bird,i);
		ds_list_add(all_scores, inst.fitness);
		ds_list_add(all_ids, inst);
	}
	for(i=0;i<instance_number(obj_frozen_bird);i+=1){
		inst = instance_find(obj_frozen_bird,i);
		ds_list_add(all_scores, inst.fitness);
		ds_list_add(all_ids, inst);
	}
	

	//give each bird a rank based on performance
	rank = 0;
	while(ds_list_size(all_ids)>0){
			
		max_val = scr_list_max(all_scores);
		idx = ds_list_find_index(all_scores,max_val);
		id_bird = ds_list_find_value(all_ids, idx);
		
		id_bird.rank = rank;
		ds_list_delete(all_ids, idx);
		ds_list_delete(all_scores,idx);
		rank+=1;
			
	}
	
	//add all the best birds to all_ids.
	for(i=0;i<instance_number(obj_bird);i+=1){
		inst = instance_find(obj_bird,i);
		if inst.rank<birds_best_N{
			ds_list_add(all_ids,inst);	
		}
	}
	for(i=0;i<instance_number(obj_frozen_bird);i+=1){
		inst = instance_find(obj_frozen_bird,i);
		if inst.rank<birds_best_N{
			ds_list_add(all_ids,inst);	
		}
	}
	
	
	//sort the list
	all_ids_sorted = ds_list_create()
	while(ds_list_size(all_ids)>0){
		
		for(i=0;i<ds_list_size(all_ids);i+=1){
			inst = ds_list_find_value(all_ids,i);
			if inst.rank = ds_list_size(all_ids_sorted){
				ds_list_add(all_ids_sorted, inst);
				ds_list_delete(all_ids, i);
				break;
			}
		}
	}
	ds_list_copy(all_ids, all_ids_sorted);
	ds_list_destroy(all_ids_sorted);
	
	
	// copy the fitness score and neural networks to the frozen birds.
	var all_NN_to_copy = ds_list_create();
	for(i=0;i<instance_number(obj_frozen_bird);i+=1){
		
		inst = ds_list_find_value(all_ids,i);
		ds_list_add(all_NN_to_copy, [inst.fitness,inst.NN]);
	}
	for(i=0;i<instance_number(obj_frozen_bird);i+=1){
		inst = instance_find(obj_frozen_bird,i);
		val_to_copy = ds_list_find_value(all_NN_to_copy,i);
		inst.fitness = val_to_copy[0];
		inst.NN = val_to_copy[1];
	}
	ds_list_destroy(all_NN_to_copy);
	
	
	// Make it so that the best reproduce more : add the inst with the best rank more often.
	all_ids_best = ds_list_create();
	for(i=0;i<ds_list_size(all_ids);i+=1){
		inst = ds_list_find_value(all_ids,i);
		repeat(birds_best_N-inst.rank){
			ds_list_add(all_ids_best,inst);	
		}
	}
	ds_list_copy(all_ids,all_ids_best);
	ds_list_destroy(all_ids_best);
	
	
	//mutate and propagate the birds
	var num_birds_altered = 0
	var birds_added = 0;
	for(i=0;i<instance_number(obj_bird);i+=1){
		inst = instance_find(obj_bird,i);
		
		if inst.rank>=birds_best_N{
			
			num_birds_altered+=1;
			
			var P1 = ds_list_find_value(all_ids,irandom_range(0,ds_list_size(all_ids)-1));
			var P2 = ds_list_find_value(all_ids,irandom_range(0,ds_list_size(all_ids)-1));
			
			inst.NN = scr_NN_merge(P1.NN, P2.NN, inst.NN);		//merge parents
			
			if random(1)<birds_ch_heavy_mutate{// heavy mutation
				inst.NN = scr_NN_initialize(num_inputs, num_hidden_layers,num_neurons, num_outputs);
			}
			else{
				inst.NN = scr_NN_mutate(inst.NN, birds_chance_to_mutate, birds_frac_to_mutate, birds_min_val_weights);
			}
			inst.c_color = -1;
		}	
		
		//directly clone the frozen birds into the set
		if inst.rank > instance_number(obj_bird)-instance_number(obj_frozen_bird) and birds_added<instance_number(obj_frozen_bird){
			var instfb = instance_find(obj_frozen_bird,birds_added);	
			inst.NN = scr_NN_pass_struct(instfb.NN, inst.NN);
			birds_added +=1;
			//show_message(birds_added);
			inst.c_color = c_red;
		}
		
	}
	
	//reset the values for the birds (start in the same location again)
	for(i=0;i<instance_number(obj_bird);i+=1){
		inst = instance_find(obj_bird,i);
		
		inst.x = birds_start_x + irandom_range(-64,64);		//just for visualisation
		inst.y = birds_start_y;
		inst.v_cur = 0;
		inst.to_flap = false;
		inst.fitness = 0;
		inst.todestroy = false;	
	}
	
	ds_list_destroy(all_ids_best);


	//reset the Lvl
	with(obj_pipe){
		instance_destroy();	
	}
	with(obj_pipe_dual){
		instance_destroy();	
	}
	//create initial lvl (initial pipe)
	for(var i=0;i<2;i+=1){
		inst = instance_create_depth(pipe_start_x-i*pipe_hor_diff, 	irandom_range(pipe_start_y_min, pipe_start_y_max),-2, obj_pipe_dual);
	}
	
	//find next pipe
	global.next_pipe = -1;
	diff_x_cur = room_width*2;
	for(i=0;i<instance_number(obj_pipe_dual);i+=1){
		var inst = instance_find(obj_pipe_dual,i);
		if (inst.x>birds_start_x+10){
			var diff_x = inst.x-birds_start_x;
			if diff_x<diff_x_cur{
				global.next_pipe = inst;
				diff_x_cur = diff_x;
			}
		}
	}
	
	//set highscore
	highscore_tot = max(highscore_cur, highscore_tot);
	highscore_cur = 0;
	
	
	//destroy our ds lists, so we prevent data leak
	ds_list_destroy(all_scores);
	ds_list_destroy(all_ids);
	
	//check it
	global.phase = 1;
	current_generation +=1;
	
}



