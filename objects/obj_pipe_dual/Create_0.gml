/// @description  Initialize variables for the dual pipe,

/*
	This object controls 2 pipes which are on the same x coordinate
	When this (invisible) object moves, the pipes it control move as well
	When it is destroyed, its obj_pipes are destroyed as well
*/

top_pipe = -1		//The ids of the 2 pipe which make up this pipe
bottom_pipe = -1;

pipe_diff = 200;	//The vertical difference between the pipes

to_create = true;	//if Set to true, will create the 2 obj_pipe which are part of this
scored = false;		//whether we scored this set of pipes already