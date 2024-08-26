if(attackstate == playerattackstate.hit) attackstate = playerattackstate.attacking

var _dt = delta_time/1000000

var inputrl = keyboard_check(ord("D"))-keyboard_check(ord("A"))
var inputud = keyboard_check(ord("S"))-keyboard_check(ord("W"))

var movedirection = round(point_direction(0,0,inputrl,inputud))

dsList = ds_list_create();
curDepth = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oDepth, false, true, dsList, false);

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
	
if(round(torsoInd)==2) attackstate = playerattackstate.hit
