///@desc
///@param

#macro DEBUG false
#macro DEV:DEBUG true

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
	DEFEND,
	ATTACK,
	HURT

}

function initGame(){
	initParticles();
	
	global.difficulty = 1;
	global.act = 1;
	global.stage = 1;
	
}

