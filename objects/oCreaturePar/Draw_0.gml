var height = clamp((y-oWaveManager.DistFromTop)/(global.heightto64),0,1)*64

shader_set(sWaterDraw)
WDtexelW = texture_get_texel_width(sprite_get_texture(sprite_index,image_index))
WDtexelH = texture_get_texel_height(sprite_get_texture(sprite_index,image_index))
var uvs = sprite_get_uvs(sprite_index, image_index)
	
shader_set_uniform_f(uWDpixelDims,WDtexelW,WDtexelH)
shader_set_uniform_f(uPercent,height)
shader_set_uniform_f(_uniUV, uvs[0], uvs[1], uvs[2], uvs[3]);
	
draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_white,image_alpha);
shader_reset()