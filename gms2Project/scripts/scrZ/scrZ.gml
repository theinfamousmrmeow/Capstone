///@desc
///@param
function scrZ(){

}

///@param z
///@param height
function initZ(){
	z = argument0;
	z_size = argument1;
	zspeed = 0;
	z_grav = 0.1;
	zprevious=z
	depth = -z;
}
///@param who
function z_collide(){
	
	var o_z = other.z;
	var o_size = other.z_size;
	
	if (z<=o_z){
		//Other is above me
		return (z+z_size >= o_z-o_size);	
	}
	else {
		//Other is below me
		return (z-z_size <= o_z+o_size);
	}
}

function z_depth(){
	depth = -(floor(y));
	//if (z!=zprevious || y!=yprevious){depth=-(y+z);}
	//zprevious=z;
}

function z_distance(){
	return abs(argument0.z - argument1.z);
}
#macro Z_TERMINAL_VELOCITY -4
function z_speed(){
	if (z>0 || zspeed!=0){
	    z+=zspeed;
		//friction=0;
	    zspeed-=z_grav;
	    if (zspeed<Z_TERMINAL_VELOCITY){zspeed=Z_TERMINAL_VELOCITY;}
	    if(z<0){z=0; zspeed=0;}
	}
	else {
		//friction=0.1;
		}
}

