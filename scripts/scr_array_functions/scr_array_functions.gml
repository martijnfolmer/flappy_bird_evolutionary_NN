

/// @function scr_val_in_array(_array_check, _val)
/// @param {array} _array_check		:	The array we want to check
/// @param {int} _val				:   Which value we want to check for
/// @description	Checks whether an array contains a value. Returns -1 if not, returns index if so. Will return index of first occurence of _val


//checks whether a value is in array or not
function scr_val_in_array(_array_check, _val){
	
	if array_length(_array_check)=0{
		return -1;	//empty array, so we return
	}
	else{
		for(var i=0;i<array_length(_array_check);i+=1){
			if(_array_check[i]=_val){
				return i;	
			}
		}
		return -1;	//couldn't find the value in the array
	}
}