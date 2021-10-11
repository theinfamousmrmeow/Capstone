/// @description 
event_inherited();

//This has to spawn the enemies.
//First we determine the "brain"
brain = "1235115412" //10 Genes, each gene controls the rate at which each enemy type is spawned?
currentChromosone = 0;
gene = global.population.getCurrent();

//
tilemap = layer_tilemap_get_id("tiles_barrier");
monsters=ds_list_create();
//ds_list_add(monsters,Flailer);
ds_list_add(monsters,obj_blobman);

cam = view_get_camera(0);
screen_height=camera_get_view_height(cam);

var _challengeRating =100;
points = _challengeRating;
cheapestMonster = _challengeRating-1;

ds_list_clear(monsters);
ds_list_add(monsters,obj_blobman);

//Wave Monsters

//Wave generation
//var waveCount = ceil(room_height/camera_get_view_height(0))-1;
//var currentWave=0;
//repeat(waveCount){
//	ds_list_shuffle(monsters);
//	var _monster = ds_list_find_value(monsters,0)
//	var yy=currentWave*camera_get_view_height(0);
//	i=instance_create_depth(room_width/2,yy,0,Wave);
//	i.monsterType = _monster;
//	currentWave++;
//}


ds_list_destroy(monsters);


alarm[0]=200;

