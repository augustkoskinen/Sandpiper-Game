var _dt = delta_time/1000000

var curDepth = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oWavePar, false, true, ds_list_create(), false);

if((x<0||y<0||x>room_width||y>room_height||curDepth<depthmin||curDepth>depthmax)&&despawnwait==-1)
	despawnwait = 1;

if(despawnwait<=0&&despawnwait>-1) instance_destroy();
else if(despawnwait>0) despawnwait-=_dt;