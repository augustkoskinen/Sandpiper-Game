var hovering = (collision_point(mouse_x,mouse_y,self,true,false))

if(life<lifecount) 
	instance_destroy()
else if(life!=-1)
	lifecount+=delta_time/1000000

if(state==foodState.dragging) {
	x = mouse_x;
	y = mouse_y;
}

edible = min(life-lifecount,1)==1;

if(hovering&&edible) {
	shader_set(sWhiteOutline)
	texelW = texture_get_texel_width(sprite_get_texture(sprite_index,image_index))
	texelH = texture_get_texel_height(sprite_get_texture(sprite_index,image_index))
	shader_set_uniform_f(pixelDims,texelW,texelH)
	
	draw_sprite_ext(sprite_index,image_index,x,y+yadd,1,1,direction,c_white,min(life-lifecount,1))
	
	shader_reset();
} else 
	draw_sprite_ext(sprite_index,image_index,x,y+yadd,1,1,direction,c_white,min(life-lifecount,1))


vely+=gravy
yadd+=vely
if(yadd<=0) {
    jumpadd*=.8
    yadd = 0;
    vely = jumpadd;
}