var hovering = false;

depth = -y;

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
	depth = -10000;
}
if(state!=itemState.picked) {
	if(hovering) {
		shader_set(sWhiteOutline)
		var texelW = texture_get_texel_width(sprite_get_texture(sprite_index,type))
		var texelH = texture_get_texel_height(sprite_get_texture(sprite_index,type))
		shader_set_uniform_f(pixelDims,texelW,texelH)
		draw_sprite(sprite_index,image_index,x,y-yadd)
		shader_reset();
	} else {
		//draw sprite in water
		shader_set(sWaterDraw)

		var height = clamp((y-yadd-oWaveManager.DistFromTop)/(global.heightto64),0,1)*64
		if(instance_place(x,y-yadd,oWave)) {
			var wavecol = instance_place(x,y-yadd,oWave)
			height+=clamp(6*dsin((wavecol.y-yadd+wavecol.sprite_height-y)/360*wavecol.sprite_height),0,4)
		}
		
		var WDtexelW = texture_get_texel_width(sprite_get_texture(sprite_index,image_index))
		var WDtexelH = texture_get_texel_height(sprite_get_texture(sprite_index,image_index))
		var uvs = sprite_get_uvs(sprite_index, image_index)
	
		shader_set_uniform_f(uWDpixelDims,WDtexelW,WDtexelH)
		shader_set_uniform_f(uPercent,height)
		shader_set_uniform_f(_uniUV, uvs[0], uvs[1], uvs[2], uvs[3]);

		draw_sprite(sprite_index,image_index,x,y-yadd);

		shader_reset();
	}
}

vely+=gravy
yadd+=vely
if(yadd<=0) {
    jumpadd*=.8
    yadd = 0;
    vely = jumpadd;
}