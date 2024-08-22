function spawnWave(){
	var dataInstId = instance_find(oWaveManager, 0);
	var DepthCount = dataInstId.DepthCount;
	var DistFromTop = dataInstId.DistFromTop;
	
	var waveIds = array_create(DepthCount);
	
	for(var i = 0; i < DepthCount; i++) {
		var xSpawn = 0;
		var ySpawn = DistFromTop * i;
		array_set(waveIds, i, instance_create_depth(xSpawn, ySpawn, -i, oDepth));
	}
	return waveIds;
}