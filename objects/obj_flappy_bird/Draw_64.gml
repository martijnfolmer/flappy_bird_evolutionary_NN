/// @description 


// TESTING : draw the global.next_pipe
/*
if global.next_pipe!=-1{
	draw_circle_color(global.next_pipe.x, global.next_pipe.y,10, c_red, c_yellow, false);
}
*/


//draw the LVL itself

//the floor
draw_sprite_ext(spr_floor, 0, -20, room_height-100, 1, 1, 0, -1,1);

//draw the sides
draw_rectangle_color(0,0,vis_left_block, room_height, c_black,c_black,c_black,c_black,false);
draw_rectangle_color(vis_right_block,0,room_width,room_height, c_black,c_black,c_black,c_black,false);


//draw our current score
draw_set_font(font_score);
for (i=-3;i<=3;i+=3){
	for(j=-3;j<=3;j+=3){
		draw_text_color(room_width/2+i, 60+j, highscore_cur, c_black,c_black,c_black,c_black,1);
	}
}
draw_text(room_width/2, 60, highscore_cur);
draw_set_font(-1);



//draw information : 
draw_set_font(font_big);
draw_text(room_width-400, 50, "Current generation : "+string(current_generation));
draw_text(room_width-400, 100, "Total birds left : " +string(instance_number(obj_bird)-num_dead_birds));
draw_text(room_width-400, 200, "Highscore previous \ngenerations  : "+string(highscore_tot));
draw_set_font(-1);

//draw instructions
draw_set_font(font_big);
draw_text(50, room_height-150, "Press Z to exit");
draw_text(50, room_height-100, "Press R to restart");
draw_set_font(-1);