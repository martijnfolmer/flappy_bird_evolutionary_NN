/// @description 


// Create our 2 pipes (top pipe and bottom pipe)
if to_create{

	var inst_id = instance_create_depth(x,y+pipe_diff/2,-2, obj_pipe);
	inst_id.image_angle = 0;
	bottom_pipe = inst_id;
	inst_id = instance_create_depth(x,y-pipe_diff/2, -2, obj_pipe);
	inst_id.image_angle = 180;
	top_pipe = inst_id;

	to_create = false;
}


//move the pipes
top_pipe.x = x;
bottom_pipe.x = x;


// Destroy the pipes when they are no longer needed (so when they moved of the edge of the screen)
if x<-100{
	
	with(bottom_pipe){
		instance_destroy();	
	}
	with(top_pipe){
		instance_destroy();	
	}
	
	instance_destroy();	
}