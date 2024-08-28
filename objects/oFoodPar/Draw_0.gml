if(hurtRed>0) {
	shader_set(sDamage)
	shader_set_uniform_f(utimer,hurtRed);
	hurtRed-=delta_time/1000000*.5
}
draw_self()
shader_reset()