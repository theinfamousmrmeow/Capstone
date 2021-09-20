/// @description 
event_inherited();
 
if (hp<=0){
	switch (object_index){
		case obj_player:
			audio_play_sound(capstone_playerDeath,3,0);	
		break;
		default:
			audio_play_sound(capstone_enemyDeath,3,0);	
	}
}