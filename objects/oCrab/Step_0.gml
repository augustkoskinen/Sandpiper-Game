event_inherited()

var _dt = delta_time/1000000	
if(rundir!=-1) {
	sprite_index = scuttleSpr
	
	if(distance_to_object(oPiper)>128) rundir = -1
	else rundir = point_direction(x,y,oPiper.x,oPiper.y)+180
	
	x+=lengthdir_x(scuttleSpeed,rundir)*_dt
	y+=lengthdir_y(scuttleSpeed,rundir)*_dt
} else if(driftTime>0) {
	sprite_index = idleSpr
	x+=driftx*_dt;
	y+=drifty*_dt;
	
	driftTime-=_dt
	if(driftTime<=0) {
		scuttleTime = random_range(1,3)
		scuttlex = scuttleSpeed;
		var maxmin = random_range(16,48)
		scuttlexmax = x+maxmin
		scuttlexmin = x-maxmin
	}
} else if(scuttleTime>0) {
	sprite_index = scuttleSpr
	x+=scuttlex*_dt
	if(x<scuttlexmin) scuttlex = scuttleSpeed
	if(x>scuttlexmax) scuttlex = -scuttleSpeed
	
	scuttleTime-=_dt
	if(scuttleTime<=0) {
		driftTime = random_range(1,2);

		var dir = random_range(0,359)
		driftx = lengthdir_x(driftSpeed, dir)
		drifty = lengthdir_y(driftSpeed, dir)
	}
}

if(distance_to_object(oPiper)<96&&irandom_range(0,30)==0)
	rundir = point_direction(x,y,oPiper.x,oPiper.y)+180

depth = -y