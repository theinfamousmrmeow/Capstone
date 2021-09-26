/// @description 
event_inherited();

switch(state){
	case E_STATES.IDLE: 
		sprite_change(spr_spikor_idle,0.1);
		if (alarm[0]=-1){alarm[0]=24+random(12);}//Begin thinking;
	break;
	case E_STATES.HURT: sprite_change(spr_spikor_hurt); break;
	case E_STATES.DEFEND: sprite_change(spr_spikor_defend); break;
	case E_STATES.WALK:
		sprite_change(spr_spikor_run,0.25);
		direction=270;
		speed=maxSpeed;
	break;
	default:
		sprite_index=spr_blob_bigman;
}