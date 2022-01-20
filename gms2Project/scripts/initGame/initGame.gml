///@desc
///@param

#macro DEBUG false
#macro DEV:DEBUG true
//#macro API_URL API_URL
//LOCAL TEST
//#macro DEV:API_URL "http://127.0.0.1:49156/"
#macro DEV:API_URL "http://159.223.181.151:49155/"
//DEPLOYMENT
#macro RELEASE:API_URL "http://159.223.181.151:49155/"

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

