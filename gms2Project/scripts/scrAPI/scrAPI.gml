///@desc
///@param
function scrAPI(){

}



function initAPI(){
	global.API = {

		//Create references to each API available;
		sessions: new API(API_URL,"sessions"),
		brains:	new API(API_URL,"brains"),

		ping: function(){
			log("PING ATTEMPT: ");
			APISendRequest(API_URL+"ping","GET",json_stringify(""));
		}
		
		//brainping: function(){
		//	log("BRAIN PING ATTEMPT: ");
			
			
		//	json_encode(_payload)
		//	APISendRequest(API_URL+"brains","GET",json_stringify(""));
		//}

	}
}


function API(_url,_class) constructor{
	url = _url;
	class = _class;
	
	getAll = function(){
		//log
		var __payload = ds_map_create();
		ds_map_add(__payload,"key",-1);
		APISendRequest(url+class,"GET",__payload);
		ds_map_destroy(__payload);
	}
	//Create
	create = function(_payload){
		//var __payload = ds_map_create();
		//ds_map_add(__payload,"time",_sessionTime);
		APISendRequest(url+class,"POST",json_encode(_payload));
		//ds_map_destroy(__payload);
		
	}
	//Read
	read = function(_topN){
		var __payload = ds_map_create();
		ds_map_add(__payload,"key",_topN);
		APISendRequest(url+class,"GET",json_encode(__payload));
		ds_map_destroy(__payload);
	}
	//Update
	
	//Delete
	
}



function APISendRequest(_url,_method,_json){
	
	debuglog(_method+" To URL:"+_url)
	debuglog("\n"+string(_json));
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
	
	var __return = http_request(_url, _method, __headers, _json);
	
	//Clean Up
	ds_map_destroy(__headers);
	
	obj_API_handler.lastRequest = __return;
	
	return __return;
	
}