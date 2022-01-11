if (state = E_STATES.HURT){
	//addTrait(E_TRAITS.INCORPOREAL)
	alarm[10]=96;
}
else {removeTrait(E_TRAITS.INCORPOREAL)}
/// @description 
event_inherited();


