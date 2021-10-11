///@desc
///@param
function scrGene(){

}



#macro CHROMOSONE_DELIMITER ","

#macro GENE_DELIMITER ";"

#macro CHROMOSONE { }

#macro ENEMY_CODES ["0","1","2","3","4","5","6"]

#macro ENEMY_OBJECTS [obj_blobman,obj_octus,obj_ironsuit,obj_flappor,obj_impor,obj_ghost,obj_owlor]

#macro POPULATION_SIZE 10
#macro MUTANTS_PER_GENERATION 3
#macro MUTATIONS_PER_MUTANT 2
// 1 = more stable, 100 = less stable
#macro GENETIC_INSTABILITY 10

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



function Population(__size=POPULATION_SIZE) constructor{
	
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
		log("LOADING FILE..."+string(fileName));
		ds_list_clear(genes);
		currentGene=real(file_text_readln(__file));
		while (!file_text_eof(__file)){
			var __str = file_text_readln(__file);
			log("LINE:"+__str);
			//if (string_count(CHROMOSONE_DELIMITER,__str)>0){
				var __gene = new Gene(__str);
				ds_list_add(genes,__gene);
			//}
		}
		file_text_close(__file);
		gene = genes[| currentGene];
		//show_message(genes);
	}
	
	getCurrent = function(){
		return (genes[| currentGene]);
	}

	
	naturalSelection = function(){

				//Perform "natural" selection;
				//Find the weakest member of the population;	
				var __weakestIndex = -1;
				var __lowestFitness = infinity;
				
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
	
	nextGene = function(){
		currentGene++;
		//Check to see if we've done them all
		if (currentGene>=ds_list_size(genes)){
			//We have evaluated all genes for fitness.
			//We must now cull, crossbreed, and mutate.
			
			#macro REPLACEMENT_COUNT 1
			
			repeat(REPLACEMENT_COUNT){
				naturalSelection();
			}
			
			repeat(REPLACEMENT_COUNT){
				//TODO:  Breeding
				//these are lists, not arrays :(
				var __size = ds_list_size(genes)
				var __pos = irandom(__size)-1;
				var __firstPos = __pos;
				log("GENES:");
				log(genes)
				var __geneA = genes[| __pos];
				//Choose a mate
				while(__pos == __firstPos and __size>1){
					__pos = irandom(__size);	
				}
				var __geneB = genes[| __pos];
				
				var __newGenes = array_create(0,0);
				log(__geneA.toString())
				var __geneC = __geneA.crossbreed(__geneB);
				array_push(__newGenes,__geneC);
				//New Offspring merge into general population	
			}
			//New Offspring merge into general population
			for (var __i=0;__i<array_length(__newGenes);__i++){
				ds_list_add(genes,__newGenes[__i]);
			}
			
			//Mutation;
			repeat(MUTANTS_PER_GENERATION){
				//Select a Gene as a Mutant
				var __gene = genes[| irandom(ds_list_size(genes)-1)];
				//Mutate our Mutant
				repeat (MUTATIONS_PER_MUTANT){
					__gene.mutate(GENETIC_INSTABILITY)	
				}
			}
			
			//Start over;
			currentGene=0;
		}
		save();
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
	gene = genes[| currentGene];
	
}

function Chromosone(_typeString=string(irandom(array_length(ENEMY_CODES)-1)),_placement=random(1),_timer=random(100)) constructor
{

	var __map = getMonsterMap();
	typeString = _typeString;
	
	type = getMonsterObject(_typeString);
		

	placement = _placement;//0-1
	timer = _timer;//0 - infinity;

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
		log("GENE FROM STRING: "+string(_str))
		ds_list_clear(chromosones);
		for (var __i=0;__i<array_length(__chromosones);__i++){
			var __chromosone = __chromosones[__i];
			//Make sure this is a good string;
			if (string_count(CHROMOSONE_DELIMITER,__chromosone)>0){
				log("	CHROM:"+string(__chromosone))
				ds_list_add(chromosones,chromosoneFromString(__chromosone));
			}
			else {
				//Should probably HALT AND CATCH FIRE.
				debuglog("No Chromosone Delimiters ("+string(CHROMOSONE_DELIMITER)+") found in "+__chromosone);
			}
		}
		return self;
	}
	
	function clear(){
		//Just delete all chromosones
		ds_list_clear(chromosones);
	}
	
	function crossbreed(_otherGene){
		var __child = -1;
		var __size = ds_list_size(chromosones);
		var __changePoint = irandom_range(1,__size-2);
		
		__child = new Gene();
		__child.clear();
		
		for (var __chr=0;__chr<__size;__chr++){
			
			//Get Ternaried, n00b
			var __chromosone = __chr<__changePoint? chromosones[| __chr] : _otherGene.chromosones[| __chr];
			//log("ALL CHROMOSONES:");
			//log(chromosones);
			//log("CHROM :"+string(__chr)+":");
			//log(__chromosone);
			ds_list_add(__child.chromosones,__chromosone);
			//array_push(__child.chromosones,__chromosone);
		}
		
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
	
	function mutate(_instability){
		//Pick a random Chromosone out of my genes
		var __index = irandom(ds_list_size(chromosones)-1);
		var __chromosone = chromosones[| __index];
		log(__chromosone.toString())
		//Mutate this chromosone
		var __max = _instability;
		__chromosone.timer += max(0,random(__max) - (__max/2));
		__chromosone.placement = clamp(__chromosone.placement+((random(__max) - (__max/2))/100),0,1);
		//Sometimes change monster type?
		//This could possibly be too noisy;
		//TODO:  Come back and evaluate if this is necessary
		//New monster types will be introduced by crossbreeding with new population genes already
		if (roll(100)<=_instability){
			//Pick a new monster;
			
		}
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