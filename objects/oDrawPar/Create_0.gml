uPercent = shader_get_uniform(sWaterDraw,"uHeight")
uWDpixelDims = shader_get_uniform(sWaterDraw,"texture_Pixel")
_uniUV = shader_get_uniform(sWaterDraw, "u_uv");

drawsprite = sprite_index
drawindex = image_index
drawx = x
drawy = y
drawxscale = 1;
drawyscale = 1;
drawrot = 0;
drawcolor = c_white;
drawalpha = 0;