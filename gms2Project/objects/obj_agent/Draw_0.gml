/// @description 
event_inherited();

var yy=y;
var xx=x;
var snap=20;
var angle=(image_angle div snap ) * snap;

draw_sprite_ext(sprite_index,image_index,xx,yy-4+shadow_offset,image_xscale*facing,image_yscale*-0.5,angle,c_black,0.5);

if (jitter>0){
	xx += random(jitter) - jitter/2;
	yy += random(jitter) - jitter/2;
	gpu_set_fog(true,c_yellow,0,0);
	//angle=0;
}
else if (palette!=-1){
	pal_swap_set(palette,paletteIndex,0)	
}

draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale*facing,image_yscale,image_angle,image_blend,image_alpha);

if (jitter>0){
	gpu_set_fog(false,c_white,0,0);
}
else if (palette!=-1){
	pal_swap_reset();
}
