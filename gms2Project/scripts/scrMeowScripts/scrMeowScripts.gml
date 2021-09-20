// meowScripts is a collection of useful scripts that GMS2 could have, but doesn't.
// If you have any questions, improvements, or requests, let's talk!
// TWITTER:  https://twitter.com/infamousmrmeow
// GITHUB:  https://gist.github.com/theinfamousmrmeow/52ffdb4c5c4e76787850a4a218340663
// LAST UPDATE:  06SEP2021

#region Input Helpers and Definitions
#macro vk_a ord("A")
#macro vk_s ord("S")
#macro vk_d ord("D")
#macro vk_f ord("F")
#macro vk_w ord("W")
#macro vk_r ord("R")

#macro vk_z ord("Z")
#macro vk_x ord("X")
#macro vk_c ord("C")
#macro vk_v ord("V")
#macro vk_b ord("B")
#macro vk_n ord("N")
#macro vk_m ord("M")

#macro vk_e ord("E")
#macro vk_q ord("Q")
#macro vk_j ord("J")
#macro vk_k ord("K")
#macro vk_l ord("L")
#macro vk_colon 186

#macro kb keyboard_check
#macro kb_p keyboard_check_pressed
#macro kb_r keyboard_check_released

#macro gp gamepad_button_check
#macro gp_p gamepad_button_check_pressed
#macro gp_r gamepad_button_check_released

#macro mb_p mouse_check_button_pressed
#macro mb_r mouse_check_button_released
#macro mb mouse_check_button

#macro vk_tilde 192
#macro TILDE 192
#macro NEWLINE chr(10)

#endregion

#region Logging Macros
#macro log show_debug_message
#macro show show_message

#endregion 

#region TIME CONSTANTS
#macro SECONDS_TO_MILLISECONDS 1000
#endregion

#region sprites

///@desc Stops animation where it is.
function image_freeze(){
	image_speed=0;	
}

///@desc stops the sprite animation next time the loop finishes.
function image_finish(){
	if (image_index==0){image_speed=0;}	
}

function image_single(_image=0){
	image_index=_image;
	image_speed=0;
}

function sprite_change(_sprite,_image_speed = image_speed){
	if (sprite_index!=_sprite){sprite_index=_sprite; image_index=0;}
	image_speed=_image_speed;
}

///@function draw_stacked_sprite_ext
///@param sprite_index
///@param x
///@param y
///@param z
///@param image_xscale
///@param image_yscale
///@param image_zscale
///@param image_angle
///@param image_blend
function draw_stacked_sprite_ext() {

	var _sprite_index	= argument[0];
	var _x				= argument[1];
	var _y				= argument[2];
	var _z				= argument[3];
	var _image_xscale	= argument[4];
	var _image_yscale	= argument[5];
	var _image_zscale	= argument[6];
	var _image_angle	= argument[7];
	//var image_alpha //making alpha work with sprite stacking is out of scope of this tutorial

	_image_zscale *= 1//oCamera.image_zscale;

	// compute the amount we move each layer by
	// default direction is up (90*), and from there we want the opposite of the camera angle
	var _x_step = 0//oCamera.x_step * _image_zscale;
	var _y_step = 1//oCamera.y_step * _image_zscale;
	var _z_step = 1//oCamera.z_step;
	var _z_height = sprite_get_number(_sprite_index);

	// loop through each slice of the sprite, moving by x and y step each time
	for (var i = 0; i < _z_height; i += _z_step) {
		draw_sprite_ext(_sprite_index, i, _x - _x_step * (i+_z), _y - _y_step * (i+_z), _image_xscale, _image_yscale, _image_angle,image_blend, 1.0);
	}


}


#endregion

#region camera
///@param camera
function getViewCenterX(){
	var cam = view_get_camera(argument0);
	var left = camera_get_view_x(cam);
	var w = camera_get_view_width(cam);
	return left + w/2;
}

///@param camera
function getViewCenterY(){
	var cam = view_get_camera(argument0);
	var top = camera_get_view_y(cam);
	var h = camera_get_view_height(cam);
	return top + h/2;
}
#endregion

///@param StringToBeSplit
///@param delimiter
function splitString(){
	var str = argument0; //string to split
	var delimiter = argument1; //string to split the first string by
	var slot = 0;
	var strings=undefined; //array to hold all strings we have split
	var workingStr = ""; //uses a working array to hold the delimited data we're currently looking at
	
	for (var i = 1; i < (string_length(str)+1); i++) {
	    var currStr = string_copy(str, i, 1);
	    if (currStr == delimiter) {
	        strings[slot] = workingStr; //add this split to the array of all strings
	        slot++;
	        workingStr = "";
	    } else {
	        workingStr = workingStr + currStr;
	        strings[slot] = workingStr;
	    }
	}
	return strings;
}


#region Math


///@param 
/**
This is a bit funny to use.  Provide a value, then a weight, ad infinitum
For example:
weightedMean(x,0.1,y,0.9)
There must be an even number of arguments, or it will freak out.
The weights don't necessarily need to add up to 1.
**/
function weightedMean(){
		var valueSum=0;
		var weightSum=0;
		
		for (var i=0;i<argument_count;i=i+2){
			var weight = argument[i+1];
			var value = argument[i];
			valueSum += value * weight;
			weightSum += weight;
		}
		
		//
		return valueSum/weightSum;
}

///@description Rounds given value to the nearest indicated denomination
///@param valueToBeRounded
///@param toNearestWhat
/// roundToNearest(0.83,0.05) == 0.85;
function roundToNearest(){
	return round(argument0 / argument1) * argument1;
}

function angle_between(_angle,_angle1,_angle2){
		
}


function instance_direction(_id){
	return (point_direction(x,y,_id.x,_id.y));
}

#endregion

#region Probability

///@description Has a 1 in N chance to return true.  N of 0 is always false, N of 1 is always true.
///@param chance
function chance(){
	return (1==ceil(random(argument0)))
}

///@description Rolls a d(n).  Returns a value between 1 and n.
///@param chance
function roll(){
	return (ceil(random(argument0)))
}

#endregion

///@description Parses a / delimited string into a GMS2 DateTime object
///@param timeStampString
function parseTimestamp(){
	//lastLogin="9/3/2020"
	var array = argument0;
	var today = date_current_datetime();
	var year = array[2];
	//Android uses a 6 digit datestamp that GMS2 DOES NOT LIKE
	if (string_length(year)==2){
		year = "20"+year;}//I guess technically I'm hardcoding the 20...but it'll be good for like 980 years.
	var lastTimestamp = date_create_datetime(year, array[0], array[1], date_get_hour(today),date_get_minute(today), date_get_second(today));
	return lastTimestamp;
}

///@desc Returns if a given instance is visible in camera
///@param camera
///@param id
function instanceOnCamera(_cam,_id,_buffer=0){

	//Locals
	var __left = camera_get_view_x(_cam);
	var __right = __left+camera_get_view_width(_cam);
	var __top = camera_get_view_y(_cam);
	var __bottom = __top + camera_get_view_height(_cam);
	
	return (_id.bbox_left>=__left && _id.bbox_right <=__right && _id.bbox_top>=__top && _id.bbox_bottom<=__bottom);	
}

///@desc Inclusive between
///@param value
///@param min
///@param max
function isBetween(argument0, argument1, argument2) {
	return (argument0>=argument1 && argument0<=argument2);
}

///@desc sets image_xscale and image_yscale
///@param image_scale
function image_scale(argument0) {
	image_xscale = argument0;
	image_yscale = image_xscale;
}

function instance_random(argument0) {
	var number = instance_number(argument0);
	for (var i = 0; i < number; ++i;)
	    {
	    instances[i] = instance_find(argument0,i);
	    }
	if (number==0){instances[0]=-1;}
	return (
	instances[floor(random(array_length_1d(instances)))]
	);
}

///instance_nth_nearest(object, x, y, n);
///@param object
///@param x
///@param y
///@param n(2_is_excluding_self)
function instance_nearest_n() {

	var arg_obj = argument[0];
	var arg_x = argument[1];
	var arg_y = argument[2];
	var arg_n = argument[3];

	var list = ds_priority_create();
	arg_n = clamp(arg_n, 1, instance_number(arg_obj));
	var nearest = noone;

	with (arg_obj)
	{
		ds_priority_add(list, id, distance_to_point(arg_x, arg_y));
	}

	repeat (arg_n)
	{
		nearest = ds_priority_delete_min(list);
	}

	ds_priority_destroy(list);
	return nearest;
}

function instance_nearest_faction(_x,_y,_faction){
	
	//var __arrayOfResults = array_create(1,0);
	var __currentDist = 100000;
	var __result = -1;
	
	with (obj_agent){
		if (faction!=_faction){
			var __dist = point_distance(x,y,_x,_y);
			if (__dist<__currentDist){
				__result = id;	
				__currentDist = __dist;
			}
			//return id;
		}
	}
	
	return __result;
	//return instance_nearest_in_array(_x,_y,__arrayOfResults);
	
}

//Doesn't work??
function instance_nearest_variable_value(_x,_y,_object_index,_variableName,_variableValue,_trueOrFalse=true){
	
	//var __arrayOfResults = array_create(1,0);
	var __currentDist = 100000;
	var __result = -1;
	
	with (_object_index){
		if ((variable_instance_get(id,_variableName)==_variableName)==_trueOrFalse){
			var __dist = point_distance(x,y,_x,_y);
			if (__dist<__currentDist){
				__result = id;	
				__currentDist = __dist;
			}
			//return id;
		}
	}
	
	return __result;
	//return instance_nearest_in_array(_x,_y,__arrayOfResults);
	
}

///@desc Returns the closest instance of out the ids in the array provided;
function instance_nearest_in_array(_x,_y,_array) {


	var list = ds_priority_create();
	var nearest = noone;

	for (var i=0;i<array_length(_array);i++){
		ds_priority_add(list, id, distance_to_point(_x, _y));
	}
	
	nearest = ds_priority_find_min(list);
	
	ds_priority_destroy(list);
	return nearest;
}

///@desc Returns the nearest 1 instance out of many possible object indices
///@param x
///@param y
///@param types...
function instance_nearests() {

	var nearest=-1;
	var dist=100000;
	var currentNearest=-1;

	var i, arg;
	for (i = 2; i < argument_count; i++;)
	   {
			 currentNearest=instance_nearest(argument[0],argument[1],argument[i]);
			  if (instance_exists(currentNearest)){
				  var currentDist=point_distance(argument[0],argument[1],currentNearest.x,currentNearest.y);
				  if (currentDist<dist){
					dist=currentDist;
					nearest=currentNearest;
				  }
			  }
	}
  
	return nearest;
}

///@desc Returns the nearest instance of the Object Indices supplied in the array
///@param _x
///@param _y
///@param _arrayOfTypes
function instance_nearest_array(_x,_y,_arrTypes) {

	var nearest=-1;
	var dist=100000;
	var currentNearest=-1;
	var __typeCount = array_length(_arrTypes)

	var i, arg;
	for (i = 0; i < __typeCount; i++;)
	   {
			 currentNearest=instance_nearest(_x,_y,_arrTypes[i]);
			  if (instance_exists(currentNearest)){
				  var currentDist=point_distance(_x,_y,currentNearest.x,currentNearest.y);
				  if (currentDist<dist){
					dist=currentDist;
					nearest=currentNearest;
				  }
			  }
	}
  
	return nearest;
}




///@desc Returns the nearest instance of objects that have the supplied tag, or array of tags.
///@param _x
///@param _y
///@param _tag(String or Array)
function instance_nearest_tag(_x,_y,_tag){
	var _arrTypes = tag_get_asset_ids(_tag,asset_object);
	return (instance_nearest_array(_x,_y,_arrTypes));
}

#region Settings

///@param section
///@param key
///@param value
function setSetting(argument0, argument1, argument2) {
	ini_open("settings.ini");
	ini_write_real(argument0,argument1,argument2);
	ini_close();
}

///@param section
///@param key
///@param defaultValue
function getSetting(argument0, argument1, argument2) {

	ini_open("settings.ini");

	var thing = ini_read_real(argument0,argument1,argument2);

	ini_close();

	return thing;


}

#endregion

#region ARRAYS

function array_create_2d(_w,_h,_value=0){

	var __array

	for(var i = 0; i < _h; i++){
	  for(var j = 0; j < _w; j ++){
	    __array[j][i] = _value;
	  }
	}
	
	return __array;
	
}

///@param ArrayToSearch
///@param KeyToFind
function arrayContains(argument0, argument1) {
	return (findInArray(argument0,argument1)>=0)
}

///@param ArrayToSearch
///@param KeyToFind
function findInArray(argument0, argument1) {
	for (var i=0;i<array_length(argument0);i++){
		var value = array_get(argument0,i)
		if (value==argument1){return i;}
	}
	return -1;
}


function deepArrayContains(_array, _key){
	for (var i=0;i<array_length(_array);i++){
		
		var value = array_get(_array,i)		
		if (value==_key){return true;}
		
		if (is_array(value))
		{
			var __recursionSuccess = deepArrayContains(value,_key);	
			if (__recursionSuccess) {return true;}
		}
		
	}
	return false;
}

///@param ArrayToSearch
function arrayFindFreePlace(argument0) {
	return arrayContains(argument0,-1);
}

#endregion

///@desc Determines if an object has any children objects in the Asset Browser
///@param object_index
function object_has_children(argument0){
	var OBJECTS_BEGIN = 1;
	var OBJECTS_END = 100000;
	var _ancestor = argument0;

	for (var i=OBJECTS_BEGIN;i<OBJECTS_END;i++){
		var __obj = i;
		if (object_exists(__obj)){
			if (object_is_ancestor(__obj,_ancestor)){
				return true;
			}
		}
	}
	return false;
}
///@desc Regular old point vector
///@param x
///@param y
function vec2(_x, _y) constructor
    {
    x = _x;
    y = _y;
    static Add = function( _other )
        {
        x += _other.x;
        y += _other.y;
        }
    }

///@desc Performs as per collision_line, but using a given mp_grid
function collision_line_grid(_x1,_y1,_x2,_y2,_grid,_resolution){
	//Don't bother checking the same Tile position twice;
	var __lastTileX=-1;
	var __lastTileY=-1;
	
	var __x=_x1,__y=_y1;
	
	var __dir = point_direction(_x1,_y1,_x2,_y2);
	var __dist = point_distance(_x1,_y1,_x2,_y2);
	
	var __stepsRequired = floor(__dist / _resolution)
	
	for (var __step=0;__step<__stepsRequired;__step++){
		__x +=lengthdir_x(__step,__dir);
		__y +=lengthdir_y(__step,__dir);
		var __tileX = __x div _resolution;
		var __tileY = __y div _resolution
		
		if (__tileX!=__lastTileX || __tileY != __lastTileY){
			var __tile = mp_grid_get_cell(global.mpGrid,__tileX,__tileY);
			if (__tile==-1){return 1;}
			__lastTileX=__tileX;
			__lastTileY=__tileY;
		}
	}
	//Found nothing!
	return -1;
}

///@desc Returns an array of all the instances of the give object_index
function object_get_instances(_object_index){
	var __arr = array_create(0);
	for (var i = 0; i < instance_number(_object_index); ++i;)
	    {
	    __arr[i] = instance_find(_object_index,i);
	    }
	return __arr;
}