//resetstate
if(attackstate == playerattackstate.hit) {
	attackstate = playerattackstate.attacking
}

//needed vars
var _dt = delta_time/1000000

var hitx = dir==1 ? x+18 : x-18
var hity = y-6

curDepth = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, oWavePar, false, true, ds_list_create(), false);
var height = clamp((y-oWaveManager.DistFromTop)/(global.heightto64),0,1)*64
if(instance_place(x,y,oWave)) {
	var wavecol = instance_place(x,y,oWave)
	height+=clamp(6*dsin((wavecol.y+wavecol.sprite_height-y)/360*wavecol.sprite_height),0,4)
}
if(height>=32) {
	inDanger = true;
	if(drownwait<=0)
		drownwait = 1;
}
else {
	inDanger = false;
	drownwait = 0;
}

var inputrl = keyboard_check(ord("D"))-keyboard_check(ord("A"))
var inputud = keyboard_check(ord("S"))-keyboard_check(ord("W"))
var movedirection = round(point_direction(0,0,inputrl,inputud))

//inputs
if (inputud==0&&inputrl==0) { //no move
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
} else { //move
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
	
	//dash
	if(keyboard_check_pressed(vk_shift)&&stamina>=3&&array_get(slots,0)!=noone&&array_get(slots,0).type==4) {
		dashvelx = lengthdir_x(DASH_SPEED*(height>12 ? .75 : 1)*delta_time/1000000,movedirection)
		dashvely = lengthdir_y(DASH_SPEED*(height>12 ? .75 : 1)*delta_time/1000000,movedirection)
		stamina-=3;
		dashtime = .05;
	}
	
	//add movement
	x+=xadd
	y+=yadd
	
	if(dashtime > 0) {
		x+=dashvelx
		y+=dashvely
	}
	
	depth = -y
}

//determine item positioning
var xadd = (28*dir);
var yadd = -(state==playerstate.running ? 23 : 31);
var itemdir = 0;
if(attackstate==playerattackstate.attacking) {
	yadd = -31;
	switch(floor(torsoInd)) {
		case 1: {
			xadd = (23*dir)
			yadd = -19
			itemdir = -dir*45
			break;
		}
		case 2: {
			xadd = (22*dir)
			yadd = -13
			itemdir = -dir*65
			break;
		}
		case 3: {
			xadd = (22*dir)
			yadd = -2
			itemdir = -dir*90
			break;
		}
	}
} else if(attackstate==playerattackstate.celebrating) {
	yadd = -31;
	switch(floor(torsoInd)) {
		case 15:
		case 1: {
			xadd = (19*dir)
			yadd = -46
			itemdir = dir*45
			break;
		}
		case 13:
		case 14:
		case 9:
		case 10:
		case 5:
		case 6:
		case 2: {
			xadd = (6*dir)
			yadd = -51
			itemdir = dir*90
			break;
		}
		case 11: 
		case 12: 
		case 7: 
		case 8: 
		case 4:
		case 3: {
			xadd = (6*dir)
			yadd = -53
			itemdir = dir*90
			break;
		}
	}
}

//mouse hovering events
var hoverequipeditem = point_in_circle(mouse_x,mouse_y,x+xadd,y+yadd,16)
var hoverhelditem = point_in_circle(mouse_x,mouse_y,x-5*dir,y-(state==playerstate.running ? 23 : 25),16);
var hoveritem = (collision_point(mouse_x,mouse_y,oItem,true,false))
var hoverfood = (collision_point(mouse_x,mouse_y,oFood,true,false))

if(hoverfood!=noone && !hoverfood.edible) hoverfood = noone;

var hoveringInv = false;
if(dragitem!=noone&&collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, dragitem, false, true, ds_list_create(), false))
	hoveringInv = true;
	
//mouse click events
if(mouse_check_button(mb_left)) {
	if(dragitem==noone&&hoveritem!=noone && hoveritem.state==itemState.dropped&&mouse_check_button_pressed(mb_left)) {
        dragitem = hoveritem
        hoveritem.drag();
    } else if(dragitem==noone&&hoverfood!=noone && hoverfood.state==foodState.dropped&&mouse_check_button_pressed(mb_left)) {
        dragitem = hoverfood;
        hoverfood.drag();
    } else if(array_get(slots,1)!=noone&&hoverhelditem&&mouse_check_button_pressed(mb_left)) {
		dragitem = array_get(slots,1)
		array_get(slots,1).drag(1);
		array_set(slots,1,noone);
	} else if(array_get(slots,0)!=noone&&hoverequipeditem&&mouse_check_button_pressed(mb_left)) {
		dragitem = array_get(slots,0)
		array_get(slots,0).drag(0);
		array_set(slots,0,noone);
	} else if(!dragitem&&attackstate!=playerattackstate.celebrating) {
        attackstate = playerattackstate.attacking
	}
} else {//release mouse events
	if(dragitem) {
		if(dragitem.object_index == oItem) {
			var equipitem = array_get(slots,0)
			var helditem = array_get(slots,1)
			if(hoverequipeditem&&equipitem!=noone) {
				if(dragitem.fromslot!=-1) {
					dragitem.fromslot = -1;
					array_set(slots,1,equipitem)
					array_set(slots,0,noone)
					dragitem.pickUp(0);
				} else {
					equipitem.drop(mouse_x,mouse_y);
					array_set(slots,0,noone)
					dragitem.pickUp(0);
				}
				dragitem = noone;
			} else if(hoverhelditem&&helditem!=noone) {
				if(dragitem.fromslot!=-1) {
					dragitem.fromslot = -1;
					array_set(slots,0,helditem)
					array_set(slots,1,noone)
					dragitem.pickUp(1);
				} else {
					helditem.drop(mouse_x,mouse_y);
					array_set(slots,1,noone)
					dragitem.pickUp(1);
				}
				dragitem = noone;
			} else if(hoveringInv) {
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

//attack state manipulation
if(attackstate == playerattackstate.attacking) {
	if(dir==1) {
		torsoSprite = sPiperTorsoRA
	} else {
		torsoSprite = sPiperTorsoLA
	}
	
	if(hasAttacked == true && floor(torsoInd) >= 9) {
		attackstate = playerattackstate.idle;
		hasAttacked = false
	}
}

//draw beak item
if(array_get(slots,0)!=noone) {
	if(hoverequipeditem) {
		shader_set(sWhiteOutline)
		var texelW = texture_get_texel_width(sprite_get_texture(array_get(slots,0).holdsprite,array_get(slots,0).type))
		var texelH = texture_get_texel_height(sprite_get_texture(array_get(slots,0).holdsprite,array_get(slots,0).type))
		shader_set_uniform_f(pixelDims,texelW,texelH)
	} else {
		shader_set(sWaterDraw)

		sprite_index = array_get(slots,0).holdsprite
		WDtexelW = texture_get_texel_width(sprite_get_texture(array_get(slots,0).holdsprite,array_get(slots,0).type))
		WDtexelH = texture_get_texel_height(sprite_get_texture(array_get(slots,0).holdsprite,array_get(slots,0).type))
		uvs = sprite_get_uvs(array_get(slots,0).holdsprite,array_get(slots,0).type)
	
		shader_set_uniform_f(uWDpixelDims,WDtexelW,WDtexelH)
		shader_set_uniform_f(uPercent,clamp(height+yadd+(bbox_bottom-bbox_top)/2-2,0,max(height,0)))
		shader_set_uniform_f(_uniUV, uvs[0], uvs[1], uvs[2], uvs[3]);
		
		sprite_index = sCol;
		image_index = 0;
	}
	
	draw_sprite_ext(array_get(slots,0).holdsprite,array_get(slots,0).type, x+xadd,y+yadd,dir,1,itemdir,c_white,1)
	shader_reset();
}

//draw footprints
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

if(hoveringInv&&!(hoverequipeditem&&array_get(slots,0))&&!(hoverhelditem&&array_get(slots,1))) { //draw white outline if being hovered
	shader_set(sWhiteOutline)
	var texelW = texture_get_texel_width(sprite_get_texture(legsSprite,legsInd))
	var texelH = texture_get_texel_height(sprite_get_texture(legsSprite,legsInd))
	shader_set_uniform_f(pixelDims,texelW,texelH)
	draw_sprite(legsSprite,legsInd,x,y);
	
	texelW = texture_get_texel_width(sprite_get_texture(torsoSprite,torsoInd))
	texelH = texture_get_texel_height(sprite_get_texture(torsoSprite,torsoInd))
	shader_set_uniform_f(pixelDims,texelW,texelH)
	draw_sprite(torsoSprite,torsoInd,x,y);
	
	shader_reset();
} else { //draw sprite in water
	shader_set(sWaterDraw)
	var WDtexelW = texture_get_texel_width(sprite_get_texture(legsSprite,legsInd))
	var WDtexelH = texture_get_texel_height(sprite_get_texture(legsSprite,legsInd))
	var uvs = sprite_get_uvs(legsSprite, legsInd)
	
	shader_set_uniform_f(uWDpixelDims,WDtexelW,WDtexelH)
	shader_set_uniform_f(uPercent,height)
	shader_set_uniform_f(_uniUV, uvs[0], uvs[1], uvs[2], uvs[3]);
	
	draw_sprite(legsSprite,legsInd,x,y);
	
	WDtexelW = texture_get_texel_width(sprite_get_texture(torsoSprite,torsoInd))
	WDtexelH = texture_get_texel_height(sprite_get_texture(torsoSprite,torsoInd))
	uvs = sprite_get_uvs(torsoSprite, torsoInd)
	
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
			top.alphamax = .5;
			top.ripplemax = 1;
			
			bottom.timer = .75;
			bottom.timermax = .75;
			bottom.alphamax = .5;
			bottom.ripplemax = 1;
			
			ripplecooldown = .5;
		}
	}
}

//draw held item
if(array_get(slots,1)!=noone) {

	if(hoverhelditem) {
		shader_set(sWhiteOutline)
		var texelW = texture_get_texel_width(sprite_get_texture(array_get(slots,1).holdsprite,array_get(slots,1).type))
		var texelH = texture_get_texel_height(sprite_get_texture(array_get(slots,1).holdsprite,array_get(slots,1).type))
		shader_set_uniform_f(pixelDims,texelW,texelH)
	} else {
		shader_set(sWaterDraw)
		
		sprite_index = array_get(slots,1).holdsprite
		
		WDtexelW = texture_get_texel_width(sprite_get_texture(array_get(slots,1).holdsprite,array_get(slots,1).type))
		WDtexelH = texture_get_texel_height(sprite_get_texture(array_get(slots,1).holdsprite,array_get(slots,1).type))
		uvs = sprite_get_uvs(array_get(slots,1).holdsprite,array_get(slots,1).type)
	
		shader_set_uniform_f(uWDpixelDims,WDtexelW,WDtexelH)

		shader_set_uniform_f(uPercent,max(height-(state==playerstate.running ? 23 : 25)-2+(bbox_bottom-bbox_top)/2,0))
		shader_set_uniform_f(_uniUV, uvs[0], uvs[1], uvs[2], uvs[3]);
		
		sprite_index = sCol;
		image_index = 0;
	}
	draw_sprite_ext(array_get(slots,1).holdsprite,array_get(slots,1).type, x-5*dir,y-(state==playerstate.running ? 23 : 25),dir,1,0,c_white,1)
	shader_reset();
}

//indexs for sprites
if(array_get(slots,0)!=noone&&array_get(slots,0).type==2)
	attackspeed = 1.125;
else 
	attackspeed = 1.0;
	
torsoInd+=_dt*sprite_get_speed(torsoSprite)*(height>12 ? .75 : 1)*attackspeed
if(torsoInd>=sprite_get_number(torsoSprite)) 
	torsoInd = 0;
	
legsInd+=_dt*sprite_get_speed(legsSprite)*(height>12 ? .75 : 1)*(dashtime>0 ? DASH_SPEED/RUN_SPEED : 1)
if(legsInd>=sprite_get_number(legsSprite)) 
	legsInd = 0;

//hit/attack indexes
if((floor(torsoInd)==2 || floor(torsoInd)==3) && hitcooldown<=0 && attackstate == playerattackstate.attacking&&!hasAttacked) {
	hasAttacked = true;
	hitcooldown = 1;
	attackstate = playerattackstate.hit
} else if(hitcooldown>0 && torsoInd >= 4) hitcooldown-=_dt*sprite_get_speed(torsoSprite)

//check for damages
if(attackstate==playerattackstate.hit) {
	var attackcollist = ds_list_create()
	collision_circle_list(hitx,hity,range,oHitablePar,true,true,attackcollist,false);
	var hitnothing = true;
	
	for(var i = 0; i < ds_list_size(attackcollist); i++) {
		var col = ds_list_find_value(attackcollist,i);
		if(object_get_parent(col.object_index)==oBossPar) {
			hitnothing = false;
			col.takeDamage();
			break;
		} else if(object_get_parent(col.object_index)==oCreaturePar&&col.despawnwait==-1) {
			hitnothing = false;
			col.takeDamage();
			break;
		} else if(col.object_index==oItem) {
			hitnothing = false;
			col.digOut()
			break;
		}
	}
	if(hitnothing&& irandom_range(1,array_get(slots,0)==noone ? 10 : (array_get(slots,0).type==0 ? 5 : 10))==1) {
		createFood(irandom_range(0,1),hitx+(irandom_range(0,1) == 0 ? -1 : 1)*random_range(3,4),hity+(irandom_range(0,1) == 0 ? -1 : 1)*random_range(3,4),irandom_range(50,70))
	}
}


//ticks
rippletick+=_dt*3;

if(attackstate==playerattackstate.celebrating&&!celebratedchange&&floor(torsoInd)==2)
	celebratedchange = true;
if(attackstate==playerattackstate.celebrating&&celebratedchange&&floor(torsoInd)==0)
	attackstate = playerattackstate.idle;
	
splashcooldown-=_dt;
ripplecooldown-=_dt;

if(dashtime > 0)
	dashtime-=_dt

if(stamina<10)
	stamina+=_dt;
else 
	stamina = 10;
	
if(drownwait>0) {
	drownwait-=_dt;
	if(drownwait<=0) hp--;
}

if(hp<=0) {
	x = 0;
	y = 0;
	
	hp = 3;
}