if(current_time - counter >= timeTillSpawn) {
	counter = current_time;
	instance_create_depth(0, 0, -startingdepth-((DepthCount+2)*32), oWave);
	timeTillSpawn = random_range(3000, 7000);
	show_debug_message(timeTillSpawn);
}

depth = -1;
draw_sprite_stretched(sDepths,1,0,DistFromTop,room_width,room_height-DistFromTop+16)