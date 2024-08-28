if(hurtRed>0) {
	shader_set(sDamage)
	shader_set_uniform_f(utimer,hurtRed);
	hurtRed-=delta_time/1000000*.5
}
if(deathend<deathtimer) 
	instance_destroy()
else if(deathtimer!=-1)
	deathtimer+=delta_time/1000000

draw_sprite_ext(sprite_index,image_index,x,y,1,1,direction,c_white,min(deathend-deathtimer,1))
shader_reset()