life = -1;
value = 0;
lifecount = 0;
image_speed = 0;

edible = true;

pixelDims = shader_get_uniform(sWhiteOutline,"texture_Pixel")

vely = 0;
jumpadd = 4.5;
gravy = -.4;
yadd = 0;

state = foodState.dropped;

enum foodState {
    dragging,
    dropped
}

function drag() {
	state = foodState.dragging;
	jumpadd=0
    yadd = 0;
    vely = 0;
}

function eat() {
	oPiper.foodPoints += value;
	oPiper.celebrate();
	instance_destroy();
}

function drop(_x,_y) {
    touchedplayer = true;
    
    x = _x;
    y = _y;
	
    jumpadd = 4.5;
	
    state = foodState.dropped;
}