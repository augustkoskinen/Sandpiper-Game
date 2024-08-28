if(attackstate == playerattackstate.hit) attackstate = playerattackstate.attacking

var _dt = delta_time/1000000

var inputrl = keyboard_check(ord("D"))-keyboard_check(ord("A"))
var inputud = keyboard_check(ord("S"))-keyboard_check(ord("W"))

var movedirection = round(point_direction(0,0,inputrl,inputud))

dsList = ds_list_create();
curDepth = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oWaveManager, false, true, dsList, false);
//show_debug_message(curDepth);

if (inputud==0&&inputrl==0) {
	movedirection = -1
	state = playerstate.idle
	if(dir==1) {
		torsoSprite = sPiperTorsoR
		legsSprite = sPiperLegsR
	} else {
		torsoSprite = sPiperTorsoL
		legsSprite = sPiperLegsL
	}
} else {
	state = playerstate.running
	if(inputrl!=0)
		dir = inputrl;
	
	if(dir==1) {
		torsoSprite = sPiperTorsoRW
		legsSprite = sPiperLegsRW
	} else {
		torsoSprite = sPiperTorsoLW
		legsSprite = sPiperLegsLW
	}
	
	var xadd = lengthdir_x(RUN_SPEED*delta_time/1000000,movedirection)
	var yadd = lengthdir_y(RUN_SPEED*delta_time/1000000,movedirection)

	x+=xadd
	y+=yadd
}

var hoveritem = (collision_point(mouse_x,mouse_y,oItem,true,false))
var hoveringInv = false;

if(dragitem!=noone&&place_meeting(x,y,dragitem))
	hoveringInv = true;

if(mouse_check_button(mb_left)) {
	if(hoveritem!=noone&& hoveritem.state==itemState.dropped) {
		dragitem = hoveritem
		hoveritem.drag();
	} else if(!dragitem)
		attackstate = playerattackstate.attacking
} else {
	if(dragitem) {
		if(hoveringInv) {
			hoveritem.pickUp();
			dragitem = noone;
		} else {
			hoveritem.drop(mouse_x,mouse_y);
			dragitem = noone;
		}
	}
	
	attackstate = playerattackstate.idle
}

if(attackstate == playerattackstate.attacking) {
	if(dir==1) {
		torsoSprite = sPiperTorsoRA
	} else {
		torsoSprite = sPiperTorsoLA
	}
}

depth = -y

if(hoveringInv) {
	shader_set(sWhiteOutline)
	texelW = texture_get_texel_width(sprite_get_texture(legsSprite,legsInd))
	texelH = texture_get_texel_height(sprite_get_texture(legsSprite,legsInd))
	shader_set_uniform_f(pixelDims,texelW,texelH)
	draw_sprite(legsSprite,legsInd,x,y);
	
	texelW = texture_get_texel_width(sprite_get_texture(torsoSprite,torsoInd))
	texelH = texture_get_texel_height(sprite_get_texture(torsoSprite,torsoInd))
	shader_set_uniform_f(pixelDims,texelW,texelH)
	draw_sprite(torsoSprite,torsoInd,x,y);
	
	shader_reset();
} else {
	draw_sprite(legsSprite,legsInd,x,y);
	draw_sprite(torsoSprite,torsoInd,x,y);
}
torsoInd+=_dt*sprite_get_speed(torsoSprite)
if(torsoInd>=sprite_get_number(torsoSprite)) 
	torsoInd = 0;
	
legsInd+=_dt*sprite_get_speed(legsSprite)
if(legsInd>=sprite_get_number(legsSprite)) 
	legsInd = 0;
	
if(floor(torsoInd)==2&&hitcooldown<=0) {
	attackstate = playerattackstate.hit
	hitcooldown = 1
} else if(hitcooldown>0) hitcooldown-=_dt*sprite_get_speed(torsoSprite)

if(attackstate==playerattackstate.hit) {
	var hitx = dir==1 ? x+9 : x-9
	var hity = y-1
	
	var attackcollist = ds_list_create()
	collision_circle_list(hitx,hity,8,all,true,true,attackcollist,false);
	
	for(var i = 0; i < ds_list_size(attackcollist); i++) {
		var col = ds_list_find_value(attackcollist,i);
		if(object_get_parent(col.object_index)==oFoodPar) {
			col.takeDamage();
			break;
		} else if(col.object_index==oItem) {
			col.digOut()
			break;
		}
	}
}