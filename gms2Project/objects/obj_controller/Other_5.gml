/// @description 
event_inherited();
if (getGameState() != E_GAMESTATE.ROUND_PLAYING){
	//Do a fitness function on current gene;
	gene.fitnessFunction();
}