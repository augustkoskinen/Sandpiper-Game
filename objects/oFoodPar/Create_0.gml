hurtRed = 0;
utimer = shader_get_uniform(sDamage,"utimer")
deathtimer = -1;
deathend = 100;

function takeDamage() {
	hp--;
	if(hp<=0) {
		deathend = irandom_range(50,70)
		deathtimer = 0;
		sprite_index = deathspr;
	} else {
		hurtRed = 1;
		var dmg = instance_create_depth(x,y,-y,oDamage);
		dmg.dmg = oPiper.curdamage;
	}
}