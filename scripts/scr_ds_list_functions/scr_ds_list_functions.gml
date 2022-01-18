

/*
	These scripts all give added functionality to the {ds list variables}
*/



/*
	scr_list_flip(_list_id)		:	takes a {ds_list} and updates the values inside so first element comes last and vice versa
	scr_list_max(_list_id)		:	Gets the maximum value from a ds list
	scr_list_min(_list_id)		:	Gets the minimum value from a ds list
	scr_list_range(_list_id)	:	Gets the range of the ds list (maxval - minval)
	scr_list_sum(_list_id)		:	The summation of all the elements within the list
	scr_list_mean(_list_id)		:	The mean of all the elements within the list
*/




/// @function scr_list_flip(_list_id)
/// @param {ds_list} _list_id The list of which we want to flip the elements (0the becomes last, last becomes 0th)

function scr_list_flip(_list_id){ 
    for(var i=ds_list_size(_list_id);i>=0;i-=1) {
        ds_list_add(_list_id,ds_list_find_value(_list_id,i));
        ds_list_delete(_list_id,i);
    }
}


/// @function scr_list_max(_list_id)
/// @param {ds_list} _list_id The list of which we want the max value of

function scr_list_max(_list_id){ 
    var n = ds_list_size(_list_id);
    var maxv = ds_list_find_value(_list_id, 0);
    for (var i=1; i<n; i+=1) {
        var val = ds_list_find_value(_list_id, i);
        if (val > maxv){
			maxv = val;
		}
    }
    return maxv;
}

/// @function scr_list_min(_list_id)
/// @param {ds_list} _list_id The list of which we want the min value of

function scr_list_min(_list_id){ 
    var n = ds_list_size(_list_id);
    var minv = ds_list_find_value(_list_id, 0);
    for (var i=1; i<n; i+=1) {
        var val = ds_list_find_value(_list_id, i);
        if (val < minv){
			minv = val;
		}
    }
    return minv;
}


/// @function scr_list_range(_list_id)
/// @param {ds_list} _list_id The list we want to find the range (maxv-minv)

function scr_list_range(_list_id){ 
    var n = ds_list_size(_list_id);
    var minv = ds_list_find_value(_list_id, 0);
	var maxv = minv;
    for (var i=1; i<n; i+=1) {
        var val = ds_list_find_value(_list_id, i);
        if (val < minv){
			minv = val;
		}
		if (val > maxv){
			maxv = val	
		}
	}
    return maxv - minv;
}


/// @function scr_list_sum(_list_id)
/// @param {ds_list} _list_id The list we want the summation of all containing elements

function scr_list_sum(_list_id){ 
    var j = 0
	for (var i=0;i<ds_list_size(_list_id);i++){
		j+=ds_list_find_value(_list_id,i);
	}
	return j
}


/// @function scr_list_mean(_list_id)
/// @param {ds_list} _list_id The list we want the mean of all containing elements

function scr_list_mean(_list_id){ 
    j = scr_list_sum(_list_id);
	return j/ds_list_size(_list_id);
}
