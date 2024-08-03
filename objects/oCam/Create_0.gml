CamW = camera_get_view_width(view_camera[0]);
CamH = camera_get_view_height(view_camera[0]);

camera_set_view_pos(
	view_camera[0],
	oPiper.x - (CamW / 2),
	oPiper.y - (CamH / 2)
);