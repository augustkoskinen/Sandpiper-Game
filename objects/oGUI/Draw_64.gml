draw_set_alpha(image_alpha)
draw_sprite_stretched(sVignette,0,0,0,display_get_gui_width(),display_get_gui_height())
draw_set_alpha(1.0)

if(oPiper.inDanger&&image_alpha<1)
	image_alpha += delta_time/1000000;
else if(!oPiper.inDanger&&image_alpha>0)
	image_alpha -= delta_time/1000000;