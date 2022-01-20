/// @description 
event_inherited();
if (getGameState() != E_GAMESTATE.ROUND_PLAYING){
	//Do a fitness function on current gene;
	log("Evaluating Fitness and Sending Session Data");
	var __time = obj_hud.time;
	gene = global.population.getCurrent();
	var startingFitness = gene.fitness;
	var endingFitness = gene.fitnessFunction();

	//Do not send *impossible* values of less than 1 second or more than 10 minutes
	if (__time>SECONDS_TO_MILLISECONDS && __time < (MINUTES_TO_MILLISECONDS * 10)){
		var __payload = ds_map_create();
		ds_map_add(__payload,"brain","\""+gene.toString()+"\"");
		ds_map_add(__payload,"time",__time);
		ds_map_add(__payload,"startingFitness",startingFitness);
		ds_map_add(__payload,"endingFitness",endingFitness);
		global.API.sessions.create(__payload);

		__payload = ds_map_create();
		ds_map_clear(__payload);
		ds_map_add(__payload,"brain",gene.toString());
		ds_map_add(__payload,"fitness",endingFitness);
		global.API.brains.create(__payload);
		ds_map_destroy(__payload)
	}
	
	//Prepare for next session.
	global.population.nextGene();
	
}