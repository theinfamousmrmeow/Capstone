///@desc
///@param

#macro DEBUG false
#macro DEV:DEBUG true
//#macro API_URL API_URL
#macro API_URL "http://127.0.0.1:49156/"

enum E_FACTIONS{
	NONE,
	NUETRAL,
	MONSTER,
	PLAYER,
	COUNT
}

enum E_STATES{

	NONE,
	IDLE,
	WALK,
	JUMP,
	DEFEND,
	ATTACK,
	HURT

}

function initGame(){
	initParticles();
	initGameState();
	initAPI();
	global.population = new Population();

	global.difficulty = 1;
	global.act = 1;
	global.stage = 1;
	
}

