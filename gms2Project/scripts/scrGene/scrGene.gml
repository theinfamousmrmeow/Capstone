#macro CHROMOSONE_DELIMITER ","

#macro GENE_DELIMITER ";"

#macro CHROMOSONE { }

#macro ENEMY_CODES ["0","1","2","3","4","5","6"]

#macro ENEMY_OBJECTS [obj_blobman,obj_octus,obj_ironsuit,obj_flappor,obj_impor,obj_ghost,obj_owlor]

#macro POPULATION_SIZE 6
#macro MUTANTS_PER_GENERATION 3
#macro MUTATIONS_PER_MUTANT 3
#macro REPLACEMENT_COUNT 2
#macro EXTINCTION_THRESHOLD 500
#macro EXTINCTION_SEVERITY 1
// 1 = more stable, 100 = less stable
#macro GENETIC_INSTABILITY 15

function getMonsterObject(_charCode){
	var __index = findInArray(ENEMY_CODES,_charCode)
	return array_get(ENEMY_OBJECTS,__index);
}

function getMonsterCode(_objectIndex){
	var __index = findInArray(ENEMY_OBJECTS,_objectIndex)
	return array_get(ENEMY_OBJECTS,__index);
}

function chromosoneFromString(_string){
	//debuglog("CHROMSPLIT:"+_string);
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
		file_delete(fileName);
		var __file = file_text_open_write(fileName)
		var __genes = ds_list_size(genes);
		file_text_write_real(__file,currentGene);
		for (var __i=0;__i<__genes;__i++){
			var __gene = ds_list_find_value(genes,__i);
			file_text_writeln(__file);
			var __str = string(__gene.fitness) + "|" + __gene.toString();
			log(__str);
			file_text_write_string(__file,__str)	
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
			//if (string_count(CHROMOSONE_DELIMITER,__str)>0){0
				var __strs = splitString(__str,"|");
				var __gene = new Gene(__strs[1]);
				ds_list_add(genes,__gene);
				__gene.fitness = real(__strs[0]);
			//}
		}
		file_text_close(__file);
		gene = genes[| currentGene];
		//show_message(genes);
		log("CURRENT GENE INDEX:"+string(currentGene));
		log("LOADED GENES:");
		log(json_encode(genes));
		log("SIZE:"+string(ds_list_size(genes)));
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
					//Bubble sort
					var __gene = genes[| __i];
					var __fitness = __gene.fitness;
					if (__fitness<=__lowestFitness){
						__weakestIndex = __i;
						__lowestFitness = __fitness;
					}
				}
				
				//Purge the weakest index;
				ds_list_delete(genes,__weakestIndex);
	}
	
	findFittest = function(){
				//Find strongest gene.
				var __highestIndex = 0;
				var __highestFitness = -1;
				
				for (var __i=0;__i<ds_list_size(genes);__i++){
					//Bubble sort
					var __gene = genes[| __i];
					var __fitness = __gene.fitness;
					if (__fitness>__highestFitness){
						__highestIndex = __i;
						__highestFitness = __fitness;
					}
				}
				
				return genes[| __highestIndex];
	}
	
	nextGene = function(){
		save();
		currentGene++;
		//Check to see if we've done them all
		if (currentGene>=ds_list_size(genes)){
			//log("FINAL:"+string(getCurrent().toString()));
			//log("FINAL:"+string(getCurrent().fitness));
			//We have evaluated all genes for fitness.
			//We must now cull, crossbreed, and mutate.
			log("ENTIRE GENERATION FITNESS EVALUATED:");
			
			log("CURRENT GENES:");
			log(json_encode(genes));
			log("SIZE:"+string(ds_list_size(genes)));
			
			log("natural selection x "+string(REPLACEMENT_COUNT));
			repeat(REPLACEMENT_COUNT){
				naturalSelection();
			}
			var __newGenes = array_create(0,0);
			repeat(REPLACEMENT_COUNT){
				//TODO:  Breeding
				var __size = ds_list_size(genes)
				var __pos = clamp(irandom(__size-1),0,__size-1);	
				var __firstPos = __pos;
				log("GENE A POS: "+string(__pos) +"/"+string(ds_list_size(genes)));
				var __geneA = genes[| __pos];
				//Choose a mate
				while(__pos == __firstPos ){
					__pos = clamp(irandom(__size-1),0,__size-1);	
				}
				var __geneB = genes[| __pos];
				
				
				log("OFFSPRING:"+string(__geneA.toString()))
				var __geneC = __geneA.crossbreed(__geneB);
				array_push(__newGenes,__geneC);
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
			
			//Check to see if some extinction is necessary
			var __fittest = findFittest();
			if (__fittest.fitness<=EXTINCTION_THRESHOLD){
				log("EXTINCTION EVENT DEEMED NECESSARY");
				//Do some extinctions.
				repeat(EXTINCTION_SEVERITY){
					ds_list_shuffle(genes);
					ds_list_delete(genes,0);
				}
				repeat(EXTINCTION_SEVERITY){
					//Introduce completely random gene to inject new DNA into the system.
					ds_list_add(genes, new Gene());	
				}
			}
			//Start over;
			currentGene=0;
			ds_list_shuffle(genes);
		}
		log("SAVING POPULATION TO LOCAL TXT");
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
		ds_list_clear(chromosones);
		for (var __i=0;__i<array_length(__chromosones);__i++){
			var __chromosone = __chromosones[__i];
			//Make sure this is a good string;
			if (string_count(CHROMOSONE_DELIMITER,__chromosone)>0){
				//log("	CHROM:"+string(__chromosone))
				ds_list_add(chromosones,chromosoneFromString(__chromosone));
			}
			else {
				//Should probably HALT AND CATCH FIRE.
			}
		}
		return self;
	}
	function clear(){
		//Just delete all chromosones
		ds_list_clear(chromosones);
		fitness=-1;
	}
	function crossbreed(_otherGene){
		var __child = -1;
		var __size = ds_list_size(chromosones);
		var __changePoint = irandom_range(1,__size-2);
		
		log("PARENT A");
		log("PARENT B");
		
		__child = new Gene();
		__child.clear();
		
		for (var __chr=0;__chr<__size;__chr++){
			var __chromosone = __chr<__changePoint? chromosones[| __chr] : _otherGene.chromosones[| __chr];
			ds_list_add(__child.chromosones,__chromosone);
		}
		
		return __child;
	}
	
	function fitnessFunction(_round){
		//Determine fitness of this, from 1-1000;

		var __time = round( getRoundTime() / SECONDS_TO_MILLISECONDS );
		var __targetTime = getDesiredRoundTime();

		fitness =  max(0,1000 - (0.3*(power(__targetTime-__time,2))));
		return fitness;
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
		//New monster types will be introduced by crossbreeding with new population genes already
		if (roll(100)<=ceil(_instability/2)){
			//Pick a new monster;
				var __typeString=string(irandom(array_length(ENEMY_CODES)-1))
				__chromosone.type = getMonsterObject(__typeString);
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