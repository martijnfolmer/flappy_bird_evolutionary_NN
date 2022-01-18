/// @description 



global.phase = 0;	//our current phase, which we use to manage the game
					// 0 = initialization , 1=playing the game, 3= sorting the birds, mutating and spawning
					// There is no global.phase = 2. I'm just as shocked as you are.
					// Likely, I had something else planned for phase 2, but I can't remember it
					// But now that I got you here, I hope you are doing well. Tomorrow you will
					// do even better then today, keep up the good work and keep trying. 
					// --Martijn Folmer

randomize();		//randomize our number generator

//birds
birds_per_generation = 400;			// How many birds we create each generation
birds_start_x = 600;				// The x coordinate of where the birds start
birds_start_y = room_height/2;		// The y coordinate of where the birds start
birds_all_id = ds_list_create();	// The ds list of all the birds we are creating

//neural network variables
num_inputs=4;				//the input we give to the birds
num_hidden_layers=1;		// how many layers the dense neural network consists of
num_neurons=4;				// how many neurons each of the layers consist of
num_outputs = 1;			//[-1,1] whether to flap or not

birds_best_N = 10;			//how many birds are the best birds/ parents of next generation
birds_chance_to_mutate = 0.2
birds_frac_to_mutate = 0.2;
birds_min_val_weights = 0.01;	//the minimum value of all weights and biases
birds_ch_heavy_mutate = 0.2;		// chance a bird gets heavily mutated


birds_num_frozen = 5;		//how many birds we have frozen, which get cloned into the next generation
birds_frozen_all_id = ds_list_create()	//The id of these birds.


//pipes
global.next_pipe = -1;		// the id of the next dual pipe we got
pipe_v = -7;				// how fast the pipe moves from right to left
pipe_ver_diff = 270;		// how big the gap between pipes should be
pipe_hor_diff = 500;		// horizontal between two pipes
pipe_start_x = room_width + 100;	// The x coordinate of where pipes are spawned
pipe_start_y_min = 300;				// The y coordinates where a dual pipe can spawn
pipe_start_y_max = room_height-300;

//GUI Info
current_generation = 0;		// Which generation we are at
num_dead_birds = 0;			// How many birds have perished bravely
highscore_tot = 0;			// Highscore from previous generations
highscore_cur = 0;			// What our current highscore is


//Visual:
vis_left_block = 500;				//x coordinate of where the black box on the left stops
vis_right_block = room_width-500;	//x coordinate of where the black box on the right stops