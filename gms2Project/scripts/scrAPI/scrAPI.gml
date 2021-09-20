///@desc
///@param
function scrAPI(){

}

function APISendRequest(_url,_method,_json){
	
	switch (_method){
		case "GET":
		case "POST":
			//Do nothing, all good here
		break;
		default:
		//Halt and catch fire;
		show_error("Unrecognized method:"+string(_method),true);
	}
	
	var __headers = ds_map_create();
	//ds_map_add(map, "Content-Type", "application/x-www-form-urlencoded");
	ds_map_add(__headers, "Content-Type", "application/json");
	
	http_request(_url, _method, __headers, _json);
	
	//Clean Up
	ds_map_destroy(__headers);
}