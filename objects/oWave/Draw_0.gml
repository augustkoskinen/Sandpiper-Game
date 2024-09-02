curDepth = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oDepth, false, true, dsList, false) +  collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oWave, false, true, dsList, false);


image_index = curDepth-1;

if(y <= room_height/6+120 && !(!crashed && spd < 0)) {
	if(spd < 0 || y > room_height/6-100){
	spd -= 1*delta_time/30000;
	} else {
		spd *= .9999*delta_time/25000;
		if(spd < .5) {
			spd = -1;
		}
	}
} else if(y <= room_height/6+120){
	spd += 1*delta_time/30000;
}

if(y < room_height/6-80 && spd < 0) {
	crashed = true;
}

if {
	
}


if(y <= room_height/6 && collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, oWave, false, true) == noone && !crashed) {
	if(spd < 50) {
		spd +=  10*delta_time/30000;
		if(audio) {
			audio_play_sound(SND_WaveCrash, 1, false)
			audio = false;
		}
	} else {
		crashed = true;
	}
}

if(y > room_height/6 + 110 && spd < 0) {
	instance_destroy(self, true);
}

//show_debug_message(spd)
y -= spd*delta_time/300000;
draw_self();