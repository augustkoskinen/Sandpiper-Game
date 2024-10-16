//draw sprite in water
shader_set(sWaterDraw)

var height = clamp((y-oWaveManager.DistFromTop)/(global.heightto64),0,1)*64
if(instance_place(x,y,oWave)) {
	var wavecol = instance_place(x,y,oWave)
	height+=clamp(6*dsin((wavecol.y+wavecol.sprite_height-y)/360*wavecol.sprite_height),0,4)
}
var WDtexelW = texture_get_texel_width(sprite_get_texture(sprite_index,image_index))
var WDtexelH = texture_get_texel_height(sprite_get_texture(sprite_index,image_index))
var uvs = sprite_get_uvs(sprite_index, image_index)
	
shader_set_uniform_f(uWDpixelDims,WDtexelW,WDtexelH)
shader_set_uniform_f(uPercent,height)
shader_set_uniform_f(_uniUV, uvs[0], uvs[1], uvs[2], uvs[3]);

draw_sprite_ext(drawsprite,drawindex,drawx,drawy,drawxscale,drawyscale,drawrot,drawcolor,drawalpha);

shader_reset();