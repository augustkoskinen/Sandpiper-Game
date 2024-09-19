var hovering = false;

if(state==itemState.picked) {
    sprite_index = noone
} else if(state==itemState.dropped) {
    sprite_index = sItem
    image_index = type
    if(collision_point(mouse_x,mouse_y,self,true,false))
        hovering = true;
} else if(state==itemState.buried) {
    sprite_index = sItemSand
    image_index = type
} else if(state == itemState.dragging) {
	hovering = true;
	x = mouse_x;
	y = mouse_y;
    sprite_index = sItem
    image_index = type
}

if(hovering) {
	shader_set(sWhiteOutline)
	var texelW = texture_get_texel_width(sprite_get_texture(sprite_index,type))
	var texelH = texture_get_texel_height(sprite_get_texture(sprite_index,type))
	shader_set_uniform_f(pixelDims,texelW,texelH)
	
	draw_sprite(sprite_index,image_index,x,y-yadd)
	
	shader_reset();
} else 
	draw_sprite(sprite_index,image_index,x,y-yadd)

vely+=gravy
yadd+=vely
if(yadd<=0) {
    jumpadd*=.8
    yadd = 0;
    vely = jumpadd;
}