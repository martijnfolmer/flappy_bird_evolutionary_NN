/// @description 

if todestroy=false{ //movement
	
	fitness +=1;	//  increase the fitness score
	
	if global.phase = 1{
		//get input
		var input1 = (v_cur/v_max + 1)/2	//current speed
		var input2 = (global.next_pipe.x+pipe_width/2-x)/room_width	//the next pipes x
		var input3 = (y-global.next_pipe.y-obj_flappy_bird.pipe_ver_diff/2)/room_height;		//distance to top pipe
		var input4 = (y-global.next_pipe.y+obj_flappy_bird.pipe_ver_diff/2)/room_height;		//distance to bottom pipe
		

		input = [input1, input2, input3, input4]	//sort our input
		outp = scr_NN_feedforward(input, NN)		// run the input through our neural network

		//postprocess our output so we can set to_flap to true or false
		to_flap = outp[0]<=0 ? to_flap = false : to_flap=true;
	}
	
	// if we are going to flap, move up
	if to_flap{
		v_cur = flap_v;
		to_flap = false;
	}
	

	
	//gravity
	v_cur += grav_decc;
	
	// make sure we don't exceed limit
	if v_cur > v_max{
		v_cur = v_max;	
	}
	
	
	//actually move
	y += v_cur
	
	
	// visual ang
	ang_cur = (v_cur)/(v_max) * (ang_min - ang_max) + ang_max;
	
	
	// collisions
	if y<=0 or y>=room_height-100{//the ceiling or the floor
		todestroy = true;	
		
		fitness += 200 - abs(global.next_pipe.y - y)/room_height * 200
		
	}
	else if (place_meeting(x,y, obj_pipe)){
		todestroy = true;	
		
		fitness += 200 - abs(global.next_pipe.y - y)/room_height * 200
	}
	
	
	
}