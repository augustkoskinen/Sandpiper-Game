function createCreature(type, _x, _y) {
	switch(type) {
		//red crab
		case 0: {
			var food = instance_create_depth(_x,_y,-_y,oCrab)
			food.idleSpr = sCrabRed
			food.scuttleSpr = sCrabRedScuttle
			break;
		}
		//blue crab
		case 1: {
			var food = instance_create_depth(_x,_y,-_y,oCrab)
			food.idleSpr = sCrabBlue
			food.scuttleSpr = sCrabBlueScuttle
			break;
		}
	}
}