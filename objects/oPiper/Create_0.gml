RUN_SPEED = 200;
dir = 1;

hasAttacked = false

hitcooldown = 0;

curDepth = 0;

torsoSprite = noone;
torsoInd = 0;
legsSprite = noone;
legsInd = 0;

curdamage = 1;
hp = 10;
stamina = 10;
foodPoints = 0;
charge = 0;
chargeMax = 0;

pixelDims = shader_get_uniform(sWhiteOutline,"texture_Pixel")
dragitem = noone;
slotLength = 2;
slots = array_create(0);
createItem(0);

state = playerstate.running;
attackstate = playerattackstate.attacking;
celebratechange = false;

enum playerstate {
	idle,
	running,
	celebrating
}

enum playerattackstate {
	attacking,
	hit,
	idle
}

function celebrate() {
	state = playerstate.celebrating;
	celebratechange = false;
}