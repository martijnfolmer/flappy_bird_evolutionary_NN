/// @description drawing log


//TESTING: All of this is hidden behind the black box on the left, and only really needed for testing purposes

//align our text
draw_set_valign(fa_middle);
draw_set_halign(fa_left);

draw_set_color(c_white);

//drawing the log
for(i=0;i<ds_list_size(log);i++){
	draw_text(50, 100+i*25, ds_list_find_value(log,i));	
}

//drawing the fps
//draw_set_font(font_big);
draw_text(50, 50, "Fps cur = "+string(fps_count_t));
draw_text(50, 75, "Fps real = "+string(fps_real));

draw_set_color(-1);