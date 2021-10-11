/// @description Spawn next
event_inherited();
//
var spawned=0;
alarm[0]=100;

var chromosones = gene.chromosones;
var __totalChromosones = ds_list_size(chromosones)

for (var i=currentChromosone;i<__totalChromosones;i++){
	
	var __chromosone = chromosones[| i];
	
	var critter = instance_create_depth(-1000,-1000,9999,__chromosone.type);
	
	if (cheapestMonster<critter.value){cheapestMonster=critter.value;}
	
	if (points >= critter.value){
		//Spawn critter;
		critter.x = room_width * __chromosone.placement;
		critter.y = 0;
		critter.xstart = critter.x;
		critter.ystart = critter.y;
		points -= critter.value;
		//Get Delay
		alarm[0]= 5+__chromosone.timer;
	}
	else {
		//Dispose of critter;
		instance_destroy(critter,false);
		critter=-1;
	}
	
	if (critter){
		currentChromosone=(i+1) mod __totalChromosones;
		i=9999;	
	}
	
}