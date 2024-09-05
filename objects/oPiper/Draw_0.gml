if(attackstate == playerattackstate.hit) {
	attackstate = playerattackstate.attacking
}

var _dt = delta_time/1000000
var height = clamp((y-oWaveManager.DistFromTop)/(global.heightto32),0,1)*32

var inputrl = keyboard_check(ord("D"))-keyboard_check(ord("A"))
var inputud = keyboard_check(ord("S"))-keyboard_check(ord("W"))

var movedirection = round(point_direction(0,0,inputrl,inputud))

dsList = ds_list_create();
curDepth = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oWavePar, false, true, dsList, false);

if (inputud==0&&inputrl==0) {
	ripplefade+=_dt
	movedirection = -1
	splashcooldown=0;
	if(attackstate!=playerattackstate.celebrating)
		state = playerstate.idle
	if(dir==1) {
		if(attackstate==playerattackstate.celebrating) {
			torsoSprite = sPiperTorsoRE
		} else
			torsoSprite = sPiperTorsoR
		legsSprite = sPiperLegsR
	} else {
		if(attackstate==playerattackstate.celebrating)
			torsoSprite = sPiperTorsoLE
		else
			torsoSprite = sPiperTorsoL
		legsSprite = sPiperLegsL
	}
} else {
	ripplefade-=_dt*3
	if(attackstate!=playerattackstate.celebrating)
		state = playerstate.running
	if(inputrl!=0)
		dir = inputrl;
	
	if(dir==1) {
		if(attackstate==playerattackstate.celebrating)
			torsoSprite = sPiperTorsoRE
		else
			torsoSprite = sPiperTorsoRW
		legsSprite = sPiperLegsRW
	} else {
		if(attackstate==playerattackstate.celebrating)
			torsoSprite = sPiperTorsoLE
		else
			torsoSprite = sPiperTorsoLW
		legsSprite = sPiperLegsLW
	}
	
	
	
	var xadd = lengthdir_x(RUN_SPEED*(height>6 ? .75 : 1)*delta_time/1000000,movedirection)
	var yadd = lengthdir_y(RUN_SPEED*(height>6 ? .75 : 1)*delta_time/1000000,movedirection)

	if(floor(legsInd) == 0) {
		//audio_play_sound(SND_Footstep, 1, false, 1, 0, random_range(1.0, 1.6))
	}

	x+=xadd
	y+=yadd
}

var hoveritem = (collision_point(mouse_x,mouse_y,oItem,true,false))
var hoverfood = (collision_point(mouse_x,mouse_y,oFood,true,false))
if(hoverfood!=noone && !hoverfood.edible) hoverfood = noone;
var hoveringInv = false;

if(dragitem!=noone&&place_meeting(x,y,dragitem))
	hoveringInv = true;

if(mouse_check_button(mb_left)) {
    if(dragitem==noone&&hoveritem!=noone && hoveritem.state==foodState.dropped) {
        dragitem = hoveritem
        hoveritem.drag();
    } else if(dragitem==noone&&hoverfood!=noone && hoverfood.state==itemState.dropped) {
        dragitem = hoverfood;
        hoverfood.drag();
    } else if(!dragitem&&attackstate!=playerattackstate.celebrating) {
        attackstate = playerattackstate.attacking
	}
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
	
	if(height>1&&height<19) {
		draw_sprite_ext(height<=6?sRippleLegsTop: sRippleTorsoTop,rippletick,x,(y+1)-height,-dir,1,0,c_white,ripplefade);
	}
	
	shader_set(sWaterDraw)
	WDtexelW = texture_get_texel_width(sprite_get_texture(legsSprite,legsInd))
	WDtexelH = texture_get_texel_height(sprite_get_texture(legsSprite,legsInd))
	var uvs = sprite_get_uvs(legsSprite, legsInd)
	
	shader_set_uniform_f(uWDpixelDims,WDtexelW,WDtexelH)
	shader_set_uniform_f(uPercent,height)
	shader_set_uniform_f(_uniUV, uvs[0], uvs[1], uvs[2], uvs[3]);
	
	draw_sprite(legsSprite,legsInd,x,y);
	
	WDtexelW = texture_get_texel_width(sprite_get_texture(torsoSprite,torsoInd))
	WDtexelH = texture_get_texel_height(sprite_get_texture(torsoSprite,torsoInd))
	var uvs = sprite_get_uvs(torsoSprite, torsoInd)
	
	shader_set_uniform_f(uWDpixelDims,WDtexelW,WDtexelH)
	shader_set_uniform_f(uPercent,max(height-6,0))
	shader_set_uniform_f(_uniUV, uvs[0], uvs[1], uvs[2], uvs[3]);
	
	draw_sprite(torsoSprite,torsoInd,x,y);
	shader_reset()
	
	if(height>1&&height<19) {
		draw_sprite_ext(height<=6?sRippleLegsBottom: sRippleTorsoBottom,rippletick,x,(y+1)-height,-dir,1,0,c_white,ripplefade);
		if ((inputud!=0||inputrl!=0)&&splashcooldown<=0) {
			instance_create_depth(x,y-height+1,-(y-height+1),oWaterSplash);
			splashcooldown = .075;
		}
	}
}
torsoInd+=_dt*sprite_get_speed(torsoSprite)*(height>6 ? .75 : 1)
if(torsoInd>=sprite_get_number(torsoSprite)) 
	torsoInd = 0;
	
legsInd+=_dt*sprite_get_speed(legsSprite)*(height>6 ? .75 : 1)
if(legsInd>=sprite_get_number(legsSprite)) 
	legsInd = 0;
	
if((floor(torsoInd)==2 || floor(torsoInd)==3) && hitcooldown<=0 && attackstate == playerattackstate.attacking) {
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
		if(object_get_parent(col.object_index)==oBossPar) {
			col.takeDamage();
			break;
		} else if(object_get_parent(col.object_index)==oCreaturePar) {
			col.takeDamage();
			break;
		} else if(col.object_index==oItem) {
			col.digOut()
			break;
		}
	}
}

rippletick+=_dt*3;

if(attackstate==playerattackstate.celebrating&&!celebratedchange&&floor(torsoInd)==2)
	celebratedchange = true;
if(attackstate==playerattackstate.celebrating&&celebratedchange&&floor(torsoInd)==0)
	attackstate = playerattackstate.idle;
	
splashcooldown-=_dt;
ripplefade = clamp(ripplefade,0,1);