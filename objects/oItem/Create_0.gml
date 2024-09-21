state = itemState.buried;

pixelDims = shader_get_uniform(sWhiteOutline,"texture_Pixel")

fromslot = -1;
vely = 0;
jumpadd = 0;
gravy = -.4;
yadd = 0;

enum itemState {
    buried,
    dropped, 
    picked,
	dragging
}

function pickUp() {
	fromslot = -1;

	if(argument_count>0)
		if(array_get(oPiper.slots,argument[0])==noone) {
	        array_set(oPiper.slots,argument[0],self)
	        visible = false;
	        state = itemState.picked;
	    }
	if(state != itemState.picked)
		for(var i = 0; i < array_length(oPiper.slots); i++) {
			if(array_get(oPiper.slots,i)==noone) {
		        array_set(oPiper.slots,i,self)
		        visible = false;
		        state = itemState.picked;
				break;
		    }
		}
	if(state!=itemState.picked) {
		drop(x,y);
	}
}

function drop(_x,_y) {
    touchedplayer = true;
    
    x = _x;
    y = _y;
	
    jumpadd = 4.5;
	
    fromslot = -1;
    visible = true;
    state = itemState.dropped;
}

function drag() {
	if(argument_count>0) fromslot = argument[0];
    visible = true;
	state = itemState.dragging;
	jumpadd=0
    yadd = 0;
    vely = 0;
}

function digOut() {
    visible = true;
	if(state==itemState.buried) {
		state = itemState.dropped;
        touchedplayer = true;
        jumpadd = 4.5;
	}
}