/// @description 





// Bugtesting related : 

//TESTING : draw our debug log and show current FPS
log = ds_list_create();		// Any entries in this log will be displayed top left
log_max = 30;				//how many log entries we display, rest get deleted

fps_count = 0
fps_count_t = 0;
fps_count_n = 60;
fps_count_c = 0;


//setting the window to fullscreen
window_set_fullscreen(true);


//create flappy bird control object
inst = instance_create_depth(x,y, -1, obj_flappy_bird)

//Set the background color
lay_id = layer_get_id("Background");
back_id = layer_background_get_id(lay_id);
layer_background_blend(back_id,make_colour_rgb(3, 180, 174));	

