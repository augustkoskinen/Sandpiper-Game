curDepth = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oDepth, false, true, dsList, false);

image_index = curDepth-1;

y -= spd*delta_time/300000;

if(y <= room_height/6) {
	spd -= 1*delta_time/30000;
}

if(y > room_height/6 + 200 && spd < 0) {
	instance_destroy(self, true);
}

draw_self();