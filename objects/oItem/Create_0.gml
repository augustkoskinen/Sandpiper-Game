state = itemState.buried;

pixelDims = shader_get_uniform(sWhiteOutline,"texture_Pixel")

x = 128
y = 128

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
    if(array_length(oPiper.slots) < oPiper.slotLength) {
        array_push(oPiper.slots,self)
        
        visible = false;
        state = itemState.picked;
    }
}

function drop(_x,_y) {
    touchedplayer = true;
    
    x = _x;
    y = _y;
	
    jumpadd = 4.5;
    
    visible = true;
    state = itemState.dropped;
    
    array_delete(oPiper.slots,array_get_index(oPiper.slots,self),1)
}

function drag() {
	state = itemState.dragging;
	jumpadd=0
    yadd = 0;
    vely = 0;
}