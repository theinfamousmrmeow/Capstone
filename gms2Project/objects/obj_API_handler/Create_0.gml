/// @description 
event_inherited();

//https://grafxkid.itch.io/


var _url = "http://127.0.0.1:5000/capstone"

//http_get(_url);

get=http_get(_url);
//get = -1;
var payload = ds_map_create();
ds_map_add(payload,"potato","PO-TAY-TOES");

var map = ds_map_create();
//ds_map_add(map, "Content-Type", "application/x-www-form-urlencoded");
ds_map_add(map, "Content-Type", "application/json");
//ds_map_add(map, "Host", "127.0.0.1:5000");
//ds_map_add(map, "Connection", "keep-alive");
//ds_map_add(map, "Content-Length", "169");
//ds_map_add(map, "Cache-Control", "max-age=0");
//ds_map_add(map, "Authorization", "Basic eW95b19hZG1pbjpjNG5lZmllbGQ=");
//ds_map_add(map, "Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
//ds_map_add(map, "User-Agent", "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36");
//ds_map_add(map, "Content-Type", "application/json");
//ds_map_add(map, "Accept-Encoding", "gzip,deflate,sdch");
//ds_map_add(map, "Accept-Language", "en-GB,en-US;q=0.8,en;q=0.6");

post_string = "{\"author\":\"Jack Kerouac\",\"read\":true,\"title\":\"On the Road\"}"
post=-1;
//post = http_post_string(_url,json_encode(payload))//
post = http_request(_url, "POST", map, json_stringify("potato"));

ds_map_destroy(payload);
ds_map_destroy(map);