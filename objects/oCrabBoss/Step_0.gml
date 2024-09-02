var _dt = delta_time/1000000

if(state==crabbossstate.scuttling) {
	x+=scuttlex*_dt
	
	if(x<scuttlexmin) scuttlex = scuttleSpeed
	if(x>scuttlexmax) scuttlex = -scuttleSpeed
	
	scuttleTime-=_dt
	if(scuttleTime<=0) {
		state= crabbossstate.charging
		var dis = point_distance(x,y,oPiper.x,oPiper.y)
		var dir = point_direction(x,y,oPiper.x,oPiper.y)
		
		chargetime = dis/chargeSpeed
		
		chargeX = lengthdir_x(chargeSpeed,dir);
		chargeY = lengthdir_y(chargeSpeed,dir);
	}
} else if (state==crabbossstate.charging) {
	x+=chargeX*_dt
	y+=chargeY*_dt
	
	chargetime-=_dt
	if(chargetime<=0) {
		state= crabbossstate.scuttling
		scuttleTime = random_range(1,3)
		scuttlex = random_range(1,2)==1?scuttleSpeed:-scuttleSpeed;
		var maxmin = random_range(64,128)
		scuttlexmax = x+maxmin
		scuttlexmin = x-maxmin
	}
}

depth = -y