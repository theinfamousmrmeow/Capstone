/// @description activation

left = camera_get_view_x(cam);
left = 0;
top = camera_get_view_y(cam);
width = camera_get_view_width(cam);
width=room_width;
height = camera_get_view_height(cam);
if (lowestY<lastlowestY){
	lastlowestY=lowestY;
	instance_activate_region(left,top,width,height,true);
}

alarm[1]=2;