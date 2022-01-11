/// @description 
event_inherited();

show_debug_message("ASYNC LOAD: "+string(ds_map_values_to_array(async_load)));
if ds_map_find_value(async_load, "id") == lastRequest
    {
    if ds_map_find_value(async_load, "status") == 0
        {
        r_str = ds_map_find_value(async_load, "result");
		show_debug_message("REQUEST:"+string(r_str));
        }
    else
        {
        r_str = "null";
        }
    }

//if ds_map_find_value(async_load, "id") == post
//    {
//    if ds_map_find_value(async_load, "status") == 0
//        {
//        r_str = ds_map_find_value(async_load, "result");
//		//show_message(post);
//		//show_message(r_str);
//		show_debug_message("POST:"+r_str);
//        }
//    }