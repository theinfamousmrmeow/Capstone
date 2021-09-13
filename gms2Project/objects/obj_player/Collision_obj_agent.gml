/// @description 
event_inherited();

if (faction!=other.faction && other.touchDamage && !blinking){
	blinking=40;
	screenShake(8);
	//Get Hurt
	hp-=other.touchDamage;
	jitter=8;
	//spawnParticleAbove(x,y,global.p_impact,1);
	state = E_STATES.HURT;
	alarm[10]=18;
	zspeed=1;
}