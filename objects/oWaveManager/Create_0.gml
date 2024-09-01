DistFromTop = room_height / 6;
waveIds = array_create(DepthCount);
counter = current_time;
timeTillSpawn = 4000;



for(i = 0; i < DepthCount; i++) {
	var xSpawn = 0;
	var ySpawn = (DistFromTop * i) + DistFromTop;
	array_set(waveIds, i, instance_create_depth(xSpawn, ySpawn, -i, oDepth));
} 
instance_create_depth(0, 0, -100, oWave);