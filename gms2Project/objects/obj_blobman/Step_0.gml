/// @description 
event_inherited();

switch(state){
	case E_STATES.IDLE: 
		sprite_change(spr_ghost_float,0);
		if (alarm[0]=-1){alarm[0]=24}//Begin thinking;
	break;
	case E_STATES.HURT: sprite_change(spr_ghost_hurt); 
		if (!hasTrait(E_TRAITS.INCORPOREAL)){addTrait(E_TRAITS.INCORPOREAL);}
	break;
	//case E_STATES.DEFEND: sprite_change(spr_spikor_defend); break;
	case E_STATES.WALK:
		sprite_change(spr_ghost_float,0.25);
		direction=270;
		speed=maxSpeed;
	break;
	default:
		sprite_index=spr_blob_bigman;
}

if (hasTrait(E_TRAITS.INCORPOREAL)){
	if (image_alpha>0.5){image_alpha-=0.05;}
	maxSpeed=0;
}
else {
	if (image_alpha<1){image_alpha+=0.05;}
	maxSpeed=0.5;
}