/// @description 
event_inherited();

 if kb_p(vk_q){
	var payload = ds_map_create();
	ds_map_add(payload,"potato","PO-TAY-TOES");
	lastRequest = APISendRequest(dbUrl+"capstone","POST",json_encode(payload))	 
	log("capstone request");
 }
 
  if kb_p(vk_w){
	//var payload = ds_map_create();
	//ds_map_add(payload,"potato","PO-TAY-TOES");
	//lastRequest = APISendRequest(dbUrl+"sessions","POST",json_encode(payload))	 
	//log("sessions request");
	global.API.sessions.read(10);
 }
 
   if kb_p(vk_b){
	// var payload = ds_map_create();
	//ds_map_add(payload,"potato","PO-TAY-TOES");
	//lastRequest = APISendRequest(dbUrl+"brains","GET",json_encode(payload))	 
	global.API.brains.getAll();
	//lastRequest = APISendRequest(dbUrl+"brains","GET",json_stringify("potato"))	 
	log("brains request");
 }
 
  if kb_p(vk_e){
	global.API.ping();
 }