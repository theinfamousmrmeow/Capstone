/// @description 
event_inherited();

/// @description Insert description here
// You can write your code in this editor
if (z_collide(other)){
	if (faction!=-1 && faction!=other.faction && other.faction!=E_FACTIONS.NONE && !agentHasTrait(other,E_TRAITS.INCORPOREAL)){
		other.hp-=1;
		other.jitter=8;
		audio_play_sound(capstone_enemyDamage,2,0);
		spawnParticleAbove(x,y,global.p_impact,1);
		if (!agentHasTrait(other,E_TRAITS.UNFLINCHING)){
			other.state = E_STATES.HURT;
			other.alarm[10]=18;
		}
		if (other.hp>0 && other.faction==E_FACTIONS.MONSTER){
			//sfxPlay(sfx_monster_hurt);
			//sfxPlayWithVariance(sfx_monster_hurt,sfxPriorities.combatDamage,5);
		}
		instance_destroy();
	}
}