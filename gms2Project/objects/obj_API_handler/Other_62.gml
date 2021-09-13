/// @description 
event_inherited();
show_debug_message(async_load);
if ds_map_find_value(async_load, "id") == get
    {
    if ds_map_find_value(async_load, "status") == 0
        {
        r_str = ds_map_find_value(async_load, "result");
		show_debug_message("GET:"+string(r_str));
        }
    else
        {
        r_str = "null";
        }
    }
if ds_map_find_value(async_load, "id") == post
    {
    if ds_map_find_value(async_load, "status") == 0
        {
        r_str = ds_map_find_value(async_load, "result");
		//show_message(post);
		//show_message(r_str);
		show_debug_message("POST:"+r_str);
        }
    }