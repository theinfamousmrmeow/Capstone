/// @description 
event_inherited();

if (state!=E_STATES.HURT){
	if (inputDirection!=-1){
		motion_add(inputDirection,accel);
	}
	else {
		if (canShoot){
			canShoot=false;
			alarm[0]=rof;
			i=instance_create_depth(x,y,-9000,obj_bullet)
			i.faction=faction;
			i.owner = id;
		}
	}
}

speed=clamp(speed,-maxSpeed,maxSpeed);

if (inputDirection!=-1 && round(direction)!=round(inputDirection)){
	spawnParticle(x,bbox_bottom,global.p_dust,1);	
}