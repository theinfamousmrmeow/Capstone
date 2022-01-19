/// @description 
event_inherited();
if (getGameState() != E_GAMESTATE.ROUND_PLAYING){
	//Do a fitness function on current gene;
	log("Evaluating Fitness and Sending Session Data");
	var __time = obj_hud.time;
	var startingFitness = gene.fitness;
	var endingFitness = gene.fitnessFunction();

	//Do not send *impossible* values of less than 1 or more than 10 minutes
	if (__time>0 && __time < (60000 * 10)){
		var __payload = ds_map_create();
		ds_map_add(__payload,"brain","\""+gene.toString()+"\"");
		ds_map_add(__payload,"time",__time);
		ds_map_add(__payload,"startingFitness",startingFitness);
		ds_map_add(__payload,"endingFitness",endingFitness);
		global.API.sessions.create(__payload);
	}
	#region TODO
	////Send a create to the Brains table, ignored if already in table
	//TODO:  Game can't handle two simultaneous requests right now.
	//Make queue so these get handled.
	//This is why I'm not getting new Brains.
	//ds_map_clear(__payload);
	//ds_map_add(__payload,"brain",gene.toString());
	//ds_map_add(__payload,"fitness",endingFitness);
	//global.API.brains.create(__payload);
	#endregion
	
	//Prepare for next session.
	global.population.nextGene();
	ds_map_destroy(__payload)
}