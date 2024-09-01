if(attackstate == playerattackstate.hit) attackstate = playerattackstate.attacking

var _dt = delta_time/1000000

var inputrl = keyboard_check(ord("D"))-keyboard_check(ord("A"))
var inputud = keyboard_check(ord("S"))-keyboard_check(ord("W"))

var movedirection = round(point_direction(0,0,inputrl,inputud))

dsList = ds_list_create();
curDepth = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oWavePar, false, true, dsList, false);
//show_debug_message(curDepth);

if (inputud==0&&inputrl==0) {
	movedirection = -1
	if(state!=playerstate.celebrating)
		state = playerstate.idle
	if(dir==1) {
		if(state==playerstate.celebrating) {
			torsoSprite = sPiperTorsoRE
		} else
			torsoSprite = sPiperTorsoR
		legsSprite = sPiperLegsR
	} else {
		if(state==playerstate.celebrating)
			torsoSprite = sPiperTorsoLE
		else
			torsoSprite = sPiperTorsoL
		legsSprite = sPiperLegsL
	}
} else {
	if(state!=playerstate.celebrating)
		state = playerstate.running
	if(inputrl!=0)
		dir = inputrl;
	
	if(dir==1) {
		if(state==playerstate.celebrating)
			torsoSprite = sPiperTorsoRE
		else
			torsoSprite = sPiperTorsoRW
		legsSprite = sPiperLegsRW
	} else {
		if(state==playerstate.celebrating)
			torsoSprite = sPiperTorsoLE
		else
			torsoSprite = sPiperTorsoLW
		legsSprite = sPiperLegsLW
	}
	
	var xadd = lengthdir_x(RUN_SPEED*delta_time/1000000,movedirection)
	var yadd = lengthdir_y(RUN_SPEED*delta_time/1000000,movedirection)

	x+=xadd
	y+=yadd
}

var hoveritem = (collision_point(mouse_x,mouse_y,oItem,true,false))
var hoverfood = (collision_point(mouse_x,mouse_y,oFood,true,false))
if(hoverfood!=noone && !hoverfood.edible) hoverfood = noone;
var hoveringInv = false;

if(dragitem!=noone&&place_meeting(x,y,dragitem))
	hoveringInv = true;

if(mouse_check_button(mb_left)) { //line 66
    if(dragitem==noone&&hoveritem!=noone && hoveritem.state==foodState.dropped) {
        dragitem = hoveritem
        hoveritem.drag();
    } else if(dragitem==noone&&hoverfood!=noone && hoverfood.state==itemState.dropped) {
        dragitem = hoverfood;
        hoverfood.drag();
    } else if(!dragitem&&state!=playerstate.celebrating)
        attackstate = playerattackstate.attacking
} else {
	if(dragitem) {
		if(dragitem.object_index == oItem) {
			if(hoveringInv) {
				dragitem.pickUp();
				dragitem = noone;
			} else {
				dragitem.drop(mouse_x,mouse_y);
				dragitem = noone;
			} 
		} else if (dragitem.object_index == oFood) {
			if(hoveringInv) {
				dragitem.eat();
				dragitem = noone;
			} else {
				dragitem.drop(mouse_x,mouse_y);
				dragitem = noone;
			} 
		}
	}

	//attackstate = playerattackstate.idle
}


if(attackstate == playerattackstate.attacking) {
	if(dir==1) {
		torsoSprite = sPiperTorsoRA
	} else {
		torsoSprite = sPiperTorsoLA
	}
	hasAttacked = true
	if(hasAttacked == true && floor(torsoInd) >= 9) {
		attackstate = playerattackstate.idle;
		hasAttacked = false
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
	
if((floor(torsoInd)==2 || floor(torsoInd)==3) && hitcooldown<=0) {
	attackstate = playerattackstate.hit
	hasAttacked = true;
	hitcooldown = 1;
} else if(hitcooldown>0 && torsoInd >= 4) hitcooldown-=_dt*sprite_get_speed(torsoSprite)

if(attackstate==playerattackstate.hit) {
	var hitx = dir==1 ? x+9 : x-9
	var hity = y-3
	
	var attackcollist = ds_list_create()
	collision_circle_list(hitx,hity,12,all,true,true,attackcollist,false);
	
	for(var i = 0; i < ds_list_size(attackcollist); i++) {
		var col = ds_list_find_value(attackcollist,i);
		if(object_get_parent(col.object_index)==oCreaturePar) {
			col.takeDamage();
			break;
		} else if(col.object_index==oItem) {
			col.digOut()
			break;
		}
	}
}

//show_debug_message(floor(torsoInd))






if(state==playerstate.celebrating&&!celebratechange&&floor(torsoInd)==2)
	celebratechange = true;
if(state==playerstate.celebrating&&celebratechange&&floor(torsoInd)==0)
	state = playerstate.idle;