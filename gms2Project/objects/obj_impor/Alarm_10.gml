/// @description 
if (state == E_STATES.HURT){
	//Try to jump away;
	state = E_STATES.JUMP;
	var __dodgeSpeed=1;
	if (x>room_width/2){hspeed=-__dodgeSpeed;}
	else {hspeed=__dodgeSpeed;}
	vspeed=-__dodgeSpeed/2;
	zspeed=__dodgeSpeed;
}

// Inherit the parent event
event_inherited();
