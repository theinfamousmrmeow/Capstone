/// @description 
event_inherited();

switch(state){
	case E_STATES.IDLE:
		if (y<room_height/2) {
			sprite_change(spr_impor_stand,0);
			if (alarm[0]=-1){alarm[0]=24+random(12);}//Begin thinking;
		}
	break;
		case E_STATES.HURT: sprite_change(spr_impor_hurt);
	break;
	//case E_STATES.DEFEND: sprite_change(spr_spikor_defend); break;
	case E_STATES.WALK:
		sprite_change(spr_impor_run,0.25);
		direction=270;
		speed=maxSpeed;
		if (y>=room_height/2){state = E_STATES.IDLE;}
	break;
	default:
		sprite_index=spr_blob_bigman;
}


if (canShoot && state != E_STATES.HURT){
	var __enemy = instance_nearest(x,y,obj_player)
	if (__enemy != noone){
		canShoot=false;
		alarm[1]=rof;
		var __i = instance_create_depth(x,y,-9999,obj_enemy_bullet);
		__i.faction=faction;
		__i.direction=point_direction(x,y,obj_player.x,obj_player.y);
		__i.speed=1;
		__i.image_blend=c_red;
	}
}