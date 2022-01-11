/// @description 
event_inherited();

if (getGameState()==E_GAMESTATE.ROUND_PLAYING){
	//Update Timer!
	if (last_current_time=-1){last_current_time=current_time;}
	time += (current_time-last_current_time);
	last_current_time = current_time;
}