/// @description Restart (R) and quit (Z)

if(keyboard_check_pressed(ord("R"))){	// restart the game
	game_restart();
}
if(keyboard_check_pressed(ord("Z"))){	// exit the game
	game_end();	
}



fps_count_c +=1;
fps_count+= fps_real;
if(fps_count_c>=fps_count_n){
	fps_count_t = fps_count/fps_count_c;
	fps_count = 0;
	fps_count_c = 0;
}




// check the neural networks
if keyboard_check_pressed(ord("1")){

/*
	_NN1 = scr_NN_initialize(num_inputs, num_hidden_layers, num_neurons, num_outputs);	
	_NN2 = scr_NN_initialize(num_inputs, num_hidden_layers, num_neurons, num_outputs);

	_NN3 = scr_NN_initialize(num_inputs, num_hidden_layers, num_neurons, num_outputs);
	
	_NN1 = scr_NN_mutate(_NN1, 0.2, 0.2, 0.01);
	_NN3 = scr_NN_merge(_NN1, _NN2, _NN3);
*/

	inst = instance_create_depth(mouse_x,mouse_y,-2,obj_bird);

	scr_log("This worked");
}


