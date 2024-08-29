hurtRed = 0;
utimer = shader_get_uniform(sDamage,"utimer")
deathtimer = -1;
deathend = 100;

//particles
global.psystem = part_system_create();
bloodps = part_type_create()
bloodpsem = part_emitter_create(global.psystem)

part_type_sprite(bloodps,sBlood,0,0,1);
part_type_size(bloodps,.9,2,0,0);
part_type_life(bloodps,15,20);
part_type_speed(bloodps,2,3,0,0);
part_type_direction(bloodps,45,135,0,0);
part_type_gravity(bloodps,.3,270)

part_emitter_region(global.psystem, bloodpsem, x,x,y,y, ps_shape_ellipse, ps_distr_invgaussian);
part_emitter_relative(global.psystem, bloodpsem, true);
part_emitter_stream(global.psystem, bloodpsem, bloodps, 5);

function takeDamage() {
	if(deathtimer==-1) {
		part_system_depth(global.psystem,depth)
		part_particles_create(global.psystem,x+irandom_range(-4,4),y,bloodps,irandom_range(4,6))
		var dmg = instance_create_depth(x,y,-y,oDamage);
		dmg.dmg = oPiper.curdamage;
	
		hp--;
	
		if(hp<=0) {
			createFood(sprite_index==sCrabBlue ? 1 : 0,x,y,irandom_range(50,70))
			instance_destroy();
		} else {
			//hurtRed = 1;
		}
	}
}