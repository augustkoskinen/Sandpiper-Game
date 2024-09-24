DistFromTop = room_height / 6;
waveIds = array_create(DepthCount);
counter = current_time;
timeTillSpawn = 6000;

startingdepth = 10000;

for(i = 0; i < DepthCount; i++) {
	var xSpawn = 0;
	var ySpawn = (DistFromTop * i) + DistFromTop;
	var objectdepth = instance_create_depth(xSpawn, ySpawn, -startingdepth-i*32, oDepth);
	objectdepth.level = i
	array_set(waveIds, i, objectdepth);
} 
instance_create_depth(0, 0, -startingdepth-((DepthCount+2)*32), oWave);