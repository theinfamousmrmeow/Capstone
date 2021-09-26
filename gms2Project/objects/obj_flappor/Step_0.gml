/// @description 
event_inherited();

if (x>=room_width-bbox_width()/2 || x<=bbox_width()/2){
	targetDirection = point_direction(x,y,room_width/2,y+room_height/4);	
}

switch(state){
	case E_STATES.IDLE: 
		sprite_change(spr_bird_stand,0.1);
		if (alarm[0]=-1){alarm[0]=12+random(12);}//Begin thinking;
	break;
	case E_STATES.HURT: sprite_change(spr_bird_hurt); break;
	//case E_STATES.DEFEND: sprite_change(spr_spikor_defend); break;
	case E_STATES.WALK:
		sprite_change(spr_bird_flap,0.25);
		direction=targetDirection;
		speed=maxSpeed;
	break;
	default:
		sprite_index=spr_blob_bigman;
}