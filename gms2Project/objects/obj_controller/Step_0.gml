/// @description 
event_inherited();

switch (getGameState()){
	
	case E_GAMESTATE.NONE:
		//Start the round:
		if (alarm[8]=-1){alarm[8]=150;}
	break;
	
	case E_GAMESTATE.ROUND_PLAYING:
		//Check for loss
		if (!instance_exists(obj_player)){
			setGameState(E_GAMESTATE.ROUND_LOST);	
		}
		//Check for win!
		if (!instance_exists(obj_monster) && points<cheapestMonster){
			setGameState(E_GAMESTATE.ROUND_WON);	
		}
	break;
	
	case E_GAMESTATE.ROUND_WON:
	case E_GAMESTATE.ROUND_LOST:
		//Restart
		if (alarm[9]=-1){alarm[9]=250;}
	break;
}

fitness = gene.fitness;