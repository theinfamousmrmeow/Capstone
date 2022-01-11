///@description Deactivate if off-screen;

var cam = view_get_camera(0)
var left = camera_get_view_x(cam);
var top = camera_get_view_y(cam);
var width = camera_get_view_width(cam);
var height = camera_get_view_height(cam);
var right = left + width;
var bottom = top + height;

if !(bbox_right <=left && bbox_left <=right && bbox_top <=bottom && bbox_bottom >= top){
	instance_deactivate_object(id);
}

