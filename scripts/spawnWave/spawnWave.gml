function spawnWave(){
	var dataInstId = instance_find(oWaveManager, 0);
	var DepthCount = dataInstId.DepthCount;
	var DistFromLeft = dataInstId.DistFromLeft;
	
	var waveIds = array_create(DepthCount);
	
	for(var i = 0; i < DepthCount; i++) {
		var ySpawn = room_height;
		var xSpawn = DistFromLeft * i;
		array_set(waveIds, i, instance_create_depth(xSpawn, ySpawn, -i, oWave));
	}
	return waveIds;
}