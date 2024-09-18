var hitx = dir==1 ? x+18 : x-18
var hity = y-6

if(attackstate == playerattackstate.hit) {
	attackstate = playerattackstate.attacking
}

var _dt = delta_time/1000000
var height = clamp((y-oWaveManager.DistFromTop)/(global.heightto64),0,1)*64

var inputrl = keyboard_check(ord("D"))-keyboard_check(ord("A"))
var inputud = keyboard_check(ord("S"))-keyboard_check(ord("W"))

var movedirection = round(point_direction(0,0,inputrl,inputud))

var dsList = ds_list_create();
curDepth = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oWavePar, false, true, dsList, false);

if (inputud==0&&inputrl==0) {
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
	
	
	
	var xadd = lengthdir_x(RUN_SPEED*(height>12 ? .75 : 1)*delta_time/1000000,movedirection)
	var yadd = lengthdir_y(RUN_SPEED*(height>12 ? .75 : 1)*delta_time/1000000,movedirection)

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

if(dragitem!=noone&&collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, dragitem, false, true, ds_list_create(), false))
	hoveringInv = true;

if(mouse_check_button(mb_left)) {
    if(dragitem==noone&&hoveritem!=noone && hoveritem.state==foodState.dropped&&mouse_check_button_pressed(mb_left)) {
        dragitem = hoveritem
        hoveritem.drag();
    } else if(dragitem==noone&&hoverfood!=noone && hoverfood.state==itemState.dropped&&mouse_check_button_pressed(mb_left)) {
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

if(array_length(slots)!=0&&array_get(slots,0)!=-1) {
	if(attackstate==playerattackstate.idle)
		draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-(state==playerstate.running ? 23 : 31),dir,1,dir*45,c_white,1)
	else if(attackstate==playerattackstate.attacking) {
		switch(floor(torsoInd)) {
			case 0: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
			case 1: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(23*dir),y-19,dir,1,dir*45,c_white,1)
				break;
			}
			case 2: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(22*dir),y-13,dir,1,-dir*20,c_white,1)
				break;
			}
			case 3: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(22*dir),y-2,dir,1,-dir*45,c_white,1)
				break;
			}
			case 4: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
			case 5: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
			case 6: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
			case 7: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
			case 8: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
			case 9: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
			case 10: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
			case 11: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
			case 12: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
		}
	} else if(attackstate==playerattackstate.celebrating) {
		switch(floor(torsoInd)) {
			case 0: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(28*dir),y-31,dir,1,dir*45,c_white,1)
				break;
			}
			case 1: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(19*dir),y-46,dir,1,dir*90,c_white,1)
				break;
			}
			case 2: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-51,dir,1,dir*135,c_white,1)
				break;
			}
			case 3: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-53,dir,1,dir*135,c_white,1)
				break;
			}
			case 4: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-53,dir,1,dir*135,c_white,1)
				break;
			}
			case 5: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-51,dir,1,dir*135,c_white,1)
				break;
			}
			case 6: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-51,dir,1,dir*135,c_white,1)
				break;
			}
			case 7: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-53,dir,1,dir*135,c_white,1)
				break;
			}
			case 8: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-53,dir,1,dir*135,c_white,1)
				break;
			}
			case 9: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-51,dir,1,dir*135,c_white,1)
				break;
			}
			case 10: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-51,dir,1,dir*135,c_white,1)
				break;
			}
			case 11: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-53,dir,1,dir*135,c_white,1)
				break;
			}
			case 12: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-53,dir,1,dir*135,c_white,1)
				break;
			}
			case 13: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-51,dir,1,dir*135,c_white,1)
				break;
			}
			case 14: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(6*dir),y-51,dir,1,dir*135,c_white,1)
				break;
			}
			case 15: {
				draw_sprite_ext(sItemHold,array_get(slots,0), x+(19*dir),y-46,dir,1,dir*90,c_white,1)
				break;
			}
		}
	}
}

if(state==playerstate.running&&(ceil(legsInd-1) mod 3) == 0&&curInd!=ceil(legsInd)) {
	curInd = ceil(legsInd);
	var inst = noone;
	if(ceil(legsInd-1)==0||ceil(legsInd-1)==6) {
		inst = instance_create_layer(x,y,"FootPrint",oFootPrint)
	} else if (ceil(legsInd-1)==3){
		inst = instance_create_layer(x,y+2,"FootPrint",oFootPrint)
	}
	if(inst!=noone)
		inst.image_xscale = -dir;
}

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
	shader_set_uniform_f(uPercent,max(height-12,0))
	shader_set_uniform_f(_uniUV, uvs[0], uvs[1], uvs[2], uvs[3]);
	
	draw_sprite(torsoSprite,torsoInd,x,y);
	shader_reset()
	
	if(height>2&&height<40) {
		if ((prevLegsInd!=floor(legsInd))&&splashcooldown<=0) {
			prevLegsInd = floor(legsInd);
			instance_create_depth(x,y-height+1,-(y-height+1)+20,oWaterSplashTop);
			instance_create_depth(x,y-height+1,-(y-height+1)+(inputud>0?10:-8),oWaterSplashBottom);
			
			splashcooldown = .075;
		} else if ((inputud==0&&inputrl==0)&&ripplecooldown<=0) {
			var top = instance_create_depth(x,y-height+1,-(y-height+1)+20,oWaterSplashTop);
			var bottom = instance_create_depth(x,y-height+1,-(y-height+1)-20,oWaterSplashBottom);

			top.timer = .75;
			top.timermax = .75;
			bottom.timer = .75;
			bottom.timermax = .75;
			top.alphamax = .5;
			bottom.alphamax = .5;
			top.ripplemax = 1;
			bottom.ripplemax = 1;
			
			ripplecooldown = .5;
		}
	}
}
torsoInd+=_dt*sprite_get_speed(torsoSprite)*(height>12 ? .75 : 1)
if(torsoInd>=sprite_get_number(torsoSprite)) 
	torsoInd = 0;
	
legsInd+=_dt*sprite_get_speed(legsSprite)*(height>12 ? .75 : 1)
if(legsInd>=sprite_get_number(legsSprite)) 
	legsInd = 0;
	
if((floor(torsoInd)==2 || floor(torsoInd)==3) && hitcooldown<=0 && attackstate == playerattackstate.attacking) {
	hasAttacked = true;
	hitcooldown = 1;
	attackstate = playerattackstate.hit
} else if(hitcooldown>0 && torsoInd >= 4) hitcooldown-=_dt*sprite_get_speed(torsoSprite)

if(attackstate==playerattackstate.hit) {
	var attackcollist = ds_list_create()
	collision_circle_list(hitx,hity,24,all,true,true,attackcollist,false);
	
	for(var i = 0; i < ds_list_size(attackcollist); i++) {
		var col = ds_list_find_value(attackcollist,i);
		if(object_get_parent(col.object_index)==oBossPar) {
			col.takeDamage();
			break;
		} else if(object_get_parent(col.object_index)==oCreaturePar&&col.despawnwait==-1) {
			col.takeDamage();
			break;
		} else if(col.object_index==oItem) {
			col.digOut()
			break;
		} else if(irandom_range(1,array_length(slots)==0 ? 10 : (array_get(slots,0)==0 ? 5 : 10))==1) {
			createFood(irandom_range(0,1),hitx,hity,irandom_range(50,70))
		}
	}
}

rippletick+=_dt*3;

if(attackstate==playerattackstate.celebrating&&!celebratedchange&&floor(torsoInd)==2)
	celebratedchange = true;
if(attackstate==playerattackstate.celebrating&&celebratedchange&&floor(torsoInd)==0)
	attackstate = playerattackstate.idle;
	
splashcooldown-=_dt;
ripplecooldown-=_dt;