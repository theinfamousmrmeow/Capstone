///@desc
///@param
function scrGene(){

}

function Population() constructor {
		
}

#macro CHROMOSONE = { }

function chromosoneFromString(_string){
	
	var __strs = splitSTring(_string,",");
	
	
	
	var __chr = new Chromosone()
	
	return __chr;
}

function Chromosone(_typeString=choose("0","1","2"),_placement=random(1),_timer=random(100)) constructor
{

	var __map = getMonsterMap();
	typeString = ds_map_find_value(__map,type);
	ds_map_add()
	ds_map_destroy(__map);
	type = _type; //Object Index to spawn;
		

	placement = _placement;//0-100;
	timer = _timer;//

	function toString(){
		
		var __str = string(typeString)+","+string(placement)+","+string(timer);		
		return __str;
		
	}
	
	function fromString(_string){
		var __strings = splitString(_string,",")
		//0
		type = __strings[0];
		placement = real(__strings[1]);
		timer = real(__strings[2]);
	}
	
}

function Gene() constructor {
	//Gene consists of Chromosones in a list
	fitness = undefined;//Unknown until tried;
	chromosones = ds_list_create();
	repeat(32){
		ds_list_add(chromosones,new Chromosone());
	}
	
	function toString(){
		var __str= "";
		for (var __i=0;__i<ds_list_size(chromosones);__i++){
			__str = __str + chromosones[| __i].toString() + "\n";
		}
		return __str;
	}
	
	function breedWith(_otherGene){
		var __child = -1;
		return __child;
	}
	
	function fitnessFunction(_round){
		//Determine fitness of this, from 1-1000;

		var __time = round( getRoundTime() / SECONDS_TO_MILLISECONDS );
		var __targetTime = getDesiredRoundTime();

		fitness =  max(0,1000 - (0.3*(power(__targetTime-__time,2))));
		return fitness;
		//show("__time:"+string(__time)+"\n __targetTime:"+string(__targetTime)+"\n"+
		//+string(__targetTime-__time)+"\n"
		//+string(power(__targetTime-__time,2))+"\n"
		//+string(fitness))
		//fitness = 1;
	}
	
}

function getDesiredRoundTime(){
	return 60
}

function getMonsterMap(){
	var _map = ds_map_create();
	ds_map_add(_map,"0",obj_blobman);
	ds_map_add(_map,"1",obj_ironsuit);
	ds_map_add(_map,"2",obj_octus);
	return _map;
}