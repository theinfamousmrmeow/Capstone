///@desc Entities can have traits.
///@param
function scrTraits(){

}

//These traits are for agents
enum E_TRAITS {
	NONE,
	UNDEAD,
	INCORPOREAL,
	FLYING,
	REGENERATE,//Recovers health over time
	UNFLINCHING,//Doesn't flinch when struck
	INVULNERABLE,//IMMUNE TO DAMAGE
	IMMOVABLE,//NO KNOCKBACK
	COUNT
}
//These traits are for attacks
enum E_ATTACK_TRAITS {
	NONE,
	IGNITES
}

function agentHasTrait(_who,_trait){
	with (_who){
		return (hasTrait(_trait))	
	}
}
///@desc Entities can be items, attacks, or agents
function entityHasTrait(_whichEntity,_trait){
	var __traits = _whichEntity.traits;
	if (__traits!=-1) {
		return (arrayContains(__traits,_trait));
	}
	return false;
}

function hasTrait(_trait){
	if (traits!=-1) {
		return (arrayContains(traits,_trait));
	}
	return false;
}

function addTrait(_trait){
	if (traits=-1){
		traits=array_create(1,_trait);	
	}
	else {
		array_push(traits,_trait);	
	}
}

function initTraits(){
	traits=-1;	
}
