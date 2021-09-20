/// @description 
event_inherited();

if (jitter>0){jitter--;}

x=clamp(x,0+abs(sprite_width)/2,room_width-(abs(sprite_width)/2));
y=clamp(y,0-sprite_height/2,room_height+sprite_height*2);

if (hspeed<0){facing=-1} else if(hspeed>0) {facing=1;}
if (speed>0){image_speed=0.25;}else{image_speed=0;}

if (hp<=0){instance_destroy();}

if (jitter>0){
	xx=random(jitter)-jitter/2;
	yy=random(jitter)-jitter/2;
}
else {
	xx=0; yy=0;	
}

speed = clamp(speed,0,maxSpeed);

if (blinking>0 && jitter=0){
	blinking--;
	visible=(blinking/4) mod 2;
}
else {visible=true;}

z_speed();
z_depth();