
/*
	These are the scripts we use for debugging purposes
*/



/*
	scr_log(_log_message)   -->  This script will display our log messages in the top left corner of the screen.
*/





/// @function scr_log(_log_message)
/// @param {string} _log_message The message we wish to add to the log for displaying
/// @description This script will display a string in the top left corner of the screen, so we can debug it. 
/// @requirements The obj_control object must have the {ds list} log and the {int} log_max. It draws the log in a draw_gui

function scr_log(_log_message){
	if(instance_exists(obj_control)){							// Make sure obj_control exists (which has ds_list log)
		ds_list_add(obj_control.log, string(_log_message));		// Add to the log
		if(ds_list_size(obj_control.log)>obj_control.log_max){	// Make sure the log does not exceed the max number of log messages
			do{
				ds_list_delete(obj_control.log,0)	
			}
			until(ds_list_size(obj_control.log)<=obj_control.log_max);
		}
	}
}
