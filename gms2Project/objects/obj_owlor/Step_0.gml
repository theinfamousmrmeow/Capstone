/// @description 
event_inherited();
friction=0.1;
switch(state){
	case E_STATES.IDLE:
		if (z==0) {
			sprite_change(spr_owlor_idle,0);
			if (alarm[0]=-1){alarm[0]=48+random(12);}//Begin thinking;
		}
		else {
			sprite_change(spr_owlor_fly,0);
			image_index=0;
		}
	break;
		case E_STATES.HURT: sprite_change(spr_owlor_hurt);
	break;

	case E_STATES.WALK:
		friction=0;
		if (zspeed>0){
			sprite_change(spr_owlor_fly,0.5);
		}
		else {image_speed=0;}
		if (z<5){zspeed=0.5;}
		var __x = room_width/2;
		var __y = room_height/2;
		
		if (y>room_height/2){__y=ystart; __x=xstart;}
		
		var __dist = point_distance(x,y,__x,__y);
		var __dir = point_direction(x,y,__x,__y);
		if (__dist>100){
			motion_add(__dir,maxSpeed/10);
		}
		else {motion_add(direction,maxSpeed/10);}
		//speed=maxSpeed;
		//if (y>=room_height/2){state = E_STATES.IDLE;}
	break;
	default:
		sprite_index=spr_blob_bigman;
}


if (canShoot && state != E_STATES.HURT && y>(room_height*0.1)){
	var __enemy = instance_nearest(x,y,obj_player)
	if (__enemy != noone){
		phase++;
		canShoot=false;
		alarm[1]=rof;
		var __i = instance_create_depth(x,y,-9999,obj_enemy_bullet);
		__i.faction=faction;
		__i.direction=270//point_direction(x,y,obj_player.x,obj_player.y);
		__i.speed=1;
		__i.image_blend=c_red;
		
		if (phase==3){
			//
			state = E_STATES.IDLE;
			phase=0;
			alarm[1]=rof*8;
		}
	}
}