hurtRed = 0;
deathtimer = -1;
deathend = 100;

function takeDamage() {
	if(deathtimer==-1) {
		part_system_depth(global.psystem,depth)
		part_particles_create(global.psystem,x+irandom_range(-4,4),y,global.bloodps,irandom_range(4,6))
		var dmg = instance_create_depth(x,y,-y,oDamage);
		dmg.dmg = oPiper.curdamage;
	
		hp-=oPiper.curdamage
	
		if(hp<=0) {
			createFood(sprite_index==sCrabBlue ? 1 : 0,x,y,irandom_range(50,70))
			instance_destroy();
		} else {
			//hurtRed = 1;
		}
	}
}