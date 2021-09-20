/// @description 
event_inherited();

//https://grafxkid.itch.io/


var _url = "http://127.0.0.1:5000/sessions"


get=http_get(_url);
var payload = ds_map_create();
ds_map_add(payload,"potato","PO-TAY-TOES");

var map = ds_map_create();
ds_map_add(map, "Content-Type", "application/json");

post = http_request(_url, "POST", map, json_stringify("potato"));

ds_map_destroy(payload);
ds_map_destroy(map);

