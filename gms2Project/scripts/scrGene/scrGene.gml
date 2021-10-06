///@desc
///@param
function scrGene(){

}



#macro CHROMOSONE_DELIMITER ","

#macro GENE_DELIMITER ";"

#macro CHROMOSONE { }

#macro ENEMY_CODES ["0","1","2","3","4","5"]

#macro ENEMY_OBJECTS [obj_blobman,obj_octus,obj_ironsuit,obj_flappor,obj_impor,obj_ghost]

function getMonsterObject(_charCode){
	var __index = findInArray(ENEMY_CODES,_charCode)
	return array_get(ENEMY_OBJECTS,__index);
}

function getMonsterCode(_objectIndex){
	var __index = findInArray(ENEMY_OBJECTS,_objectIndex)
	return array_get(ENEMY_OBJECTS,__index);
}


function chromosoneFromString(_string){
	debuglog("CHROMSPLIT:"+_string);
	var __strings = splitString(_string,CHROMOSONE_DELIMITER);
	var __type = __strings[0];
	var __placement = real(__strings[1]);
	var __timer = real(__strings[2]);
	
	var __chr = new Chromosone(__type,__placement,__timer);
	
	return __chr;
}

function Population(__size=5) constructor{
	
	size = __size;
	genes = ds_list_create();
	currentGene = 0;
	fileName = "POPULATION.TXT";
	
	save = function(){
		var __file = file_text_open_write(fileName)
		var __genes = ds_list_size(genes);
		file_text_write_real(__file,currentGene);
		//file_text_writeln(__file);
		for (var __i=0;__i<__genes;__i++){
			var __gene = ds_list_find_value(genes,__i);
			file_text_writeln(__file);
			file_text_write_string(__file,__gene.toString())	
		}
		file_text_close(__file);
	}
	
	load = function(){
		var __file = file_text_open_read(fileName);
		ds_list_clear(genes);
		currentGene=real(file_text_readln(__file));
		while (!file_text_eof(__file)){
			var __str = file_text_readln(__file);
			//if (string_count(CHROMOSONE_DELIMITER,__str)>0){
				var __gene = new Gene(__str);
				ds_list_add(genes,__gene);
			//}
		}
		file_text_close(__file);
		//show_message(genes);
	}
	
	getCurrent = function(){
		return (genes[| currentGene]);
	}
	
	//INITIALIZE;	
	if (file_exists(fileName)){
		load();
	}
	else {
		repeat (size){
			ds_list_add(genes,new Gene());
		}
		save();
	}
	
	nextGene = function(){
		currentGene++;
		if (currentGene>=ds_list_size(genes)){
			//We have evaluated all genes for fitness.
			//We must now cull, crossbreed, and mutate.
			
			#macro REPLACEMENT_COUNT 4
			
			repeat(REPLACEMENT_COUNT){
				//Perform "natural" selection;
				//Find the weakest member of the population;	
				var __weakestIndex = -1;
				var __lowestFitness = 10000;
				
				for (var __i=0;__i<ds_list_size(genes);__i++){
					//
					var __gene = genes[| __i];
					var __fitness = __gene.fitness;
					if (__fitness<__lowestFitness){
						__weakestIndex = __i;
						__lowestFitness = __fitness;
					}
				}
				
				//Purge the weakest index;
				ds_list_delete(genes,__weakestIndex);
			}
			
			repeat(REPLACEMENT_COUNT){
				//TODO:  Breeding
				//Perform Crossover/Breeding
				
				//Mutate every other offspring
			}
			
			//Start over;
			currentGene=0;
		}
		save();
	}
	
	//INITIALIZE
	gene = genes[| currentGene];
	
}

function Chromosone(_typeString=choose("0","1","2","3","4","5"),_placement=random(1),_timer=random(100)) constructor
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

function Gene(_str=-1) constructor {

	
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
		for (var __i=0;__i<array_length(__chromosones);__i++){
			var __chromosone = __chromosones[__i];
			//Make sure this is a good string;
			if (string_count(CHROMOSONE_DELIMITER,__chromosone)>0){
				ds_list_add(chromosones,chromosoneFromString(__chromosone));
			}
		}
		return self;
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
	
	//Initialize;
	//Gene consists of Chromosones in a list
	fitness = -1;//Unknown until tried;
	chromosones = ds_list_create();
	repeat(16){
		ds_list_add(chromosones,new Chromosone());
	}
	if (_str!=-1){
		fromString(_str);	
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