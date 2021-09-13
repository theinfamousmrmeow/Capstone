/// @description Insert description here
// You can write your code in this editor
width = camera_get_view_width(cam);
height = camera_get_view_height(cam);
if (y<lowestY){lowestY=y;}
target = instance_nearest(x,y,obj_player);
if (target>0){
	x = mean(target.x,x,x,x,x,x,x);
	x= clamp(x,width/2,room_width-width/2);
	y = lerp(y,target.y,0.1);
	//if (lowestY<height*(2/3)){lowestY=height*(2/3);}
	if (y>lowestY){y=lowestY;}
}
else {

	

}

//camera_set_view_pos(cam,x+(random(jitter*2)-jitter)-width/2,y-height/2+(random(jitter*2)-jitter));
y=clamp(y,0+height*(2/3),room_height-height*(1/2));
x=clamp(x,0+width/2,room_width-width/2);

//camera_set_view_pos(cam,x+(random(jitter*2)-jitter)-width/2,y-height*(1/2)+(random(jitter*2)-jitter));
camera_set_view_pos(cam,x+(random(jitter*2)-jitter)-width/2,y-height*(2/3)+(random(jitter*2)-jitter));



