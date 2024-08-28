if(current_time - counter >= timeTillSpawn) {
	counter = current_time;
	instance_create_depth(0, 0, -100, oWave);
}