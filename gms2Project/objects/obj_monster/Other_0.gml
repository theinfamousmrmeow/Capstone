/// @description 
event_inherited();

if (bbox_top>=room_height){
	//Add points back to controller pool;
	//Like a Pawn in chess
	obj_controller.points+=value;
	instance_destroy(id,false);
}