///@desc
///@param
function scrGene(){

}

function Population() constructor {
		
}

#macro CHROMOSONE_DELIMITER ","

#macro GENE_DELIMITER ";"

#macro CHROMOSONE { }

#macro ENEMY_CODES ["0","1","2","3","4"]

#macro ENEMY_OBJECTS [obj_blobman,obj_octus,obj_ironsuit,obj_flappor,obj_impor]

function getMonsterObject(_charCode){
	var __index = findInArray(ENEMY_CODES,_charCode)
	return array_get(ENEMY_OBJECTS,__index);
}

function getMonsterCode(_objectIndex){
	var __index = findInArray(ENEMY_OBJECTS,_objectIndex)
	return array_get(ENEMY_OBJECTS,__index);
}


function chromosoneFromString(_string){
	
	var __strings = splitString(_string,CHROMOSONE_DELIMITER);
	var __type = __strings[0];
	var __placement = real(__strings[1]);
	var __timer = real(__strings[2]);
	
	var __chr = new Chromosone(__type,__placement,__timer);
	
	return __chr;
}

function Chromosone(_typeString=choose("0","1","2","3","4"),_placement=random(1),_timer=random(100)) constructor
{

	var __map = getMonsterMap();
	typeString = _typeString;
	
	type = getMonsterObject(_typeString);
		

	placement = _placement;//0-100;
	timer = _timer;//

	function toString(){
		
		var __str = string(typeString)+","+string(placement)+","+string(timer);		
		return __str;
		
	}
	
	function fromString(_string){
		var __strings = splitString(_string,CHROMOSONE_DELIMITER)
		//0
		type = __strings[0];
		placement = real(__strings[1]);
		timer = real(__strings[2]);
	}
	
}

function Gene() constructor {
	//Gene consists of Chromosones in a list
	fitness = -1;//Unknown until tried;
	chromosones = ds_list_create();
	repeat(16){
		ds_list_add(chromosones,new Chromosone());
	}
	
	function toString(){
		var __str= "";
		for (var __i=0;__i<ds_list_size(chromosones);__i++){
			__str = __str + chromosones[| __i].toString() + GENE_DELIMITER;
		}
		return __str;
	}
	
	function fromString(_str){
		var __chromosones = splitString(_str,GENE_DELIMITER);
		ds_list_clear(chromosones);
		for (var __i=0;__i<ds_list_size(__chromosones);__i++){
			ds_list_add(chromosones,chromosoneFromString(__chromosones[__i]));
		}
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