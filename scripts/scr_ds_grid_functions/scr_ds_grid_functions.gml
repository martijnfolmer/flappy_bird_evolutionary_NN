/*
	All functions which add additional functionality to the {ds_grids}
*/



/*
	scr_grid_delete_column(_grid_id, _column_n)					:	Delete a column in a {ds_grid}, return it
	scr_grid_delete_row(_grid_id, _row_n)						:	Delete a row in a {ds_grid}, return it
	scr_grid_swap_row(_grid_id, _row_n1, _row_n2)				:	Swap 2 rows in a {ds_grid), return it
	scr_grid_swap_column(_grid_id, _column_n1, _column_n2)		:	Swap 2 columns in a {ds_grid}, return it
	scr_grid_draw_norm(_grid_id, _x, _y)						:	Draw the values (colored) of a ds_grid
*/





/// @function scr_grid_delete_column(_grid_id, _column_n)
/// @param {ds_grid} _grid_id, the id of the grid where we wish to delete the column from, 
/// @param {integer} _column_n, the nth column we wish to delete

function scr_grid_delete_column(_grid_id, _column_n){ 
    

    var w = ds_grid_width(_grid_id);
    var h = ds_grid_height(_grid_id);
 
    ds_grid_set_grid_region(_grid_id, _grid_id, _column_n+1, 0, w-1, h-1, _column_n, 0);
    ds_grid_resize(_grid_id, w-1, h);

}


/// @function scr_grid_delete_row(_grid_id, _row_n)
/// @param {ds_grid} _grid_id, the id of the grid where we wish to delete the column from, 
/// @param {integer} _row_n, the nth row we wish to delete

function scr_grid_delete_row(_grid_id, _row_n){ 
    

    var w = ds_grid_width(_grid_id);
    var h = ds_grid_height(_grid_id);
 
    ds_grid_set_grid_region(_grid_id, _grid_id, 0, _row_n+1, w-1, h-1, 0, _row_n);
    ds_grid_resize(_grid_id, w, h-1);
}



/// @function scr_grid_swap_row(_grid_id, _row_n1, _row_n2)
/// @param {ds_grid} _grid_id, the id of the grid where we wish to swap the rows of
/// @param {integer} _row_n1, the first row we wish to swap
/// @param {integer} _row_n2, the second row we wish to swap

function scr_grid_swap_row(_grid_id, _row_n1, _row_n2){ 
   
    var i, temp;
    i = 0;
    repeat (ds_grid_height(_grid_id)) {
        temp = ds_grid_get(_grid_id, _row_n1, i);
        ds_grid_set(_grid_id, _row_n1, i, ds_grid_get(_grid_id, _row_n2, i));
        ds_grid_set(_grid_id, _row_n2, i, temp);
        i += 1;
    }
    return 0;
}



/// @function scr_grid_swap_column(_grid_id, _column_n1, _column_n2)
/// @param {ds_grid} _grid_id, the id of the grid where we wish to swap the rows of
/// @param {integer} _column_n1, the first row we wish to swap
/// @param {integer} _column_n2, the second row we wish to swap

function scr_grid_swap_column(_grid_id, _column_n1, _column_n2){ 
   
    var i, temp;
    i = 0;
    repeat (ds_grid_width(_grid_id)) {
        temp = ds_grid_get(_grid_id, i, _column_n1);
        ds_grid_set(_grid_id, i, _column_n1, ds_grid_get(_grid_id, _column_n2, i));
        ds_grid_set(_grid_id, i, _column_n2, temp);
        i += 1;
    }
    return 0;
}



/// @function scr_grid_draw_norm(_grid_id, _x, _y)
/// @param {ds_grid} _grid_id, the id of the grid we wish to draw
/// @param {integer} _x, the screen position x coordinate
/// @param {integer} _y, the screen position y coordinate

function scr_grid_draw_norm(_grid_id, _x, _y){

	// Grid that we draw is normalized, so we draw the range from black to white
 
    var w = ds_grid_width(_grid_id);
    var h = ds_grid_height(_grid_id);
 
    var M = ds_grid_get_max(_grid_id,0,0,w-1,h-1);
    var m = ds_grid_get_min(_grid_id,0,0,w-1,h-1);
    if (M == m) var f = 0 else var f = 1/(M-m);
 
    for (var i=0; i<w; i++){
        for (var j=0; j<h; j++){
            var value = f*(ds_grid_get(_grid_id,i,j)-m);
            draw_point_color(_x+i,_y+j,make_color_hsv(0,0,clamp(255*value,0,255)));
        }
    }
 
    return 0;


}