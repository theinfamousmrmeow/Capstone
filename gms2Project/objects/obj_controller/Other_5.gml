/// @description 
event_inherited();
if (getGameState() != E_GAMESTATE.ROUND_PLAYING){
	//Do a fitness function on current gene;
	log("Evaluating Fitness and Sending Session Data");
	var startingFitness = gene.fitness;
	var endingFitness = gene.fitnessFunction();
	//Submit session data to DB!
	var __payload = ds_map_create();
	ds_map_add(__payload,"brain","\""+gene.toString()+"\"");
	ds_map_add(__payload,"time",obj_hud.time);
	ds_map_add(__payload,"startingFitness",startingFitness);
	ds_map_add(__payload,"endingFitness",endingFitness);
	global.API.sessions.create(__payload);
	
	////Send a create to the Brains table, ignored if already in table
	//ds_map_clear(__payload);
	//ds_map_add(__payload,"brain",gene.toString());
	//ds_map_add(__payload,"fitness",endingFitness);
	//global.API.brains.create(__payload);
	
	//Prepare for next session.
	global.population.nextGene();
	

	ds_map_destroy(__payload)
}