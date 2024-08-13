waveIds = array_create(DepthCount);
	
for(i = 0; i < DepthCount; i++) {
	ySpawn = room_height;
	xSpawn = DistFromLeft * i;
	array_set(waveIds, i, instance_create_depth(xSpawn, ySpawn, -i, oWave));
}


