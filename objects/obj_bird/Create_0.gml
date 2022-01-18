/// @description 

/*
	This bird has a neural network


*/


//Movement variables
v_cur = 0;				// current vertical speed
grav_decc = 0.8;		// how fast the bird accelerates down
v_max = 20;				// maximum vertical speed
flap_v = -15			// speed after flapping once
to_flap = false;		// if set to true, we flap

pipe_width = sprite_get_width(spr_pipe);	//The width of one of the pipes (used for calculating one of the inputs neural network)


// visual
ang_min = -30;		// the minimum and maximum angle of the sprite of the bird, based on its vertical speed
ang_max = 30;
ang_cur = 0;		// The current angle of the sprite of the bird, doesn't affect collisions.
c_color = -1;		// we use this to show what type of bird it is.

//functional 
todestroy = false;	//when set to true, means we have collided into something, so bird stops moving.
fitness = 0;		//the score which determines the rank of the bird (higher score = better bird)
rank = 0;			//the rank, based on the fitness score. Higher fitness = better rank = more children


