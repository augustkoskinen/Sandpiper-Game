hurtRed = 0;
utimer = shader_get_uniform(sDamage,"utimer")

function takeDamage() {
	var dmg = instance_create_depth(x,y,-y,oDamage);
	dmg.dmg = oPiper.curdamage;
	hp--;
	hurtRed = 1;
	
	if(hp<=0)
		instance_destroy()
}