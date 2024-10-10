curDepth = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oDepth, false, true, dsList, false) +  collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oWave, false, true, dsList, false);


image_index = 0//curDepth-1;

switch(state){
	case(WAVE_STATE.ROLLING_UP):
		if(y <= room_height/6 + 400){
			state = WAVE_STATE.WAITING;
			//show_debug_message("Waiting")
			break;
		}
		break;
	case(WAVE_STATE.WAITING):
		if(spd > 0) {
			spd -= 50*delta_time/1000000;
		} else {
			spd = 0;
		}
		//show_debug_message(curDepth)
		if(curDepth == 1) {
			state = WAVE_STATE.CRASHING;
			//show_debug_message("Crashing")
			break;
		}
		if(current_time - counter >= maxWaitTime) {
			counter = current_time;
			state = WAVE_STATE.CRASHING;
		}
		break;
	case(WAVE_STATE.CRASHING):
		spd = 300;
		if(y < room_height/6) {
			//show_debug_message("Washing out")
			audio_play_sound(SND_WaveCrash, 1, false);
			state = WAVE_STATE.WASHING_OUT;
		}
		break;
	case(WAVE_STATE.WASHING_OUT):
		if(spd > -400) {
			spd -= 185*delta_time/1000000;
		}
		if(y > room_height/6 + 600) {
			//show_debug_message("poof")
			instance_destroy(self, true);
		}
	break;
}

y -= spd*delta_time/1000000;

depth = -2;

draw_sprite_stretched(sprite_index,image_index,0,y,room_width,sprite_height);