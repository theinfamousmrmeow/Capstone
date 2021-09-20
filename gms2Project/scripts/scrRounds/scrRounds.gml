///@desc
///@param

enum E_GAMESTATE {
	NONE,
	ROUND_PLAYING,
	ROUND_START,
	ROUND_LOST,
	ROUND_WON,
	COUNT
}


function initGameState(){
	global.gameState = 	E_GAMESTATE.NONE;
}

function setGameState(_state){
	var _prevState = global.gameState;
	global.gameState = _state;
	switch(_state)
	{
		case E_GAMESTATE.ROUND_START:
		
		break;
		case E_GAMESTATE.ROUND_PLAYING:
	
		break;
		
	}
}

function getRoundTime(){
	return obj_hud.time;	
}

function gameStateIs(_state){
	return (global.gameState == _state);	
}

function getGameState(_state){
	return global.gameState;	
}