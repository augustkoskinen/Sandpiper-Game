event_inherited()

var _dt = delta_time/1000000

if(despawnwait==-1) {
	if(deathtimer==-1) {
		if(rundir!=-1) {
			sprite_index = scuttleSpr
	
			if(distance_to_object(oPiper)>128) rundir = -1
			else rundir = point_direction(x,y,oPiper.x,oPiper.y)+180
	
			velx=lengthdir_x(scuttleSpeed,rundir)*_dt
			vely=lengthdir_y(scuttleSpeed,rundir)*_dt
		} else if(driftTime>0) {
			sprite_index = idleSpr
			velx=driftx*_dt;
			vely=drifty*_dt;
	
			driftTime-=_dt
			if(driftTime<=0) {
				scuttleTime = random_range(1,3)
				scuttlex = irandom_range(1,2)==1?scuttleSpeed:-scuttleSpeed;
				var maxmin = random_range(16,48)
				scuttlexmax = x+maxmin
				scuttlexmin = x-maxmin
			}
		} else if(scuttleTime>0) {
			sprite_index = scuttleSpr
			velx=scuttlex*_dt
			vely=0
			if(x<scuttlexmin) scuttlex = scuttleSpeed
			if(x>scuttlexmax) scuttlex = -scuttleSpeed
	
			scuttleTime-=_dt
			if(scuttleTime<=0) {
				driftTime = random_range(1,2);
				
				var maxxdist = room_width-x
				var maxydist = room_height-y
				
				var pointx = random_range(max(-30,-x/20),min(30,maxxdist/20));
				var pointy = random_range(max(-30,-y/20),min(30,maxydist/20));
				
				var dir = point_direction(0,0,pointx,pointy)
				
				driftx = lengthdir_x(driftSpeed, dir)
				drifty = lengthdir_y(driftSpeed, dir)
			}
		}

		if(distance_to_object(oPiper)<96&&irandom_range(0,30)==0)
			rundir = point_direction(x,y,oPiper.x,oPiper.y)+180
	}
}

x+=velx
y+=vely

depth = -y
image_alpha = despawnwait==-1?1:despawnwait;