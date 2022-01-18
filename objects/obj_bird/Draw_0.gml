/// @description 


//draw self
if c_color!=-1{//outline
	draw_sprite_ext(sprite_index,0,x,y,1.2,1.2,ang_cur,c_color,1);	
	draw_sprite_ext(sprite_index,0,x,y,1,1,ang_cur,-1,1);
	draw_sprite_ext(sprite_index,0,x,y,1,1,ang_cur,c_color,0.5);
}
else{
	draw_sprite_ext(sprite_index,0,x,y,1,1,ang_cur,-1,1);
}

//This is drawn when the bird crashed into something
if todestroy{
	draw_sprite_ext(spr_cross,0,x,y,1,1,0,-1,1);	
}

//TESTING : Draw our current fitness score, which is a measure of how good the bird is doing.
draw_text(x,y-64, fitness + 200 - abs(global.next_pipe.y - y)/room_height * 200);