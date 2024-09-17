RUN_SPEED = 400;
dir = 1;

hasAttacked = false

hitcooldown = 0;

curDepth = 0;


torsoSprite = noone;
torsoInd = 0;
legsSprite = noone;
legsInd = 0;
curInd = 0;
prevLegsInd = 0;

curdamage = 1;
hp = 10;
stamina = 10;
foodPoints = 0;
charge = 0;
chargeMax = 0;

rippletick = 0;
ripplecooldown = 0;
splashcooldown = 0;


uPercent = shader_get_uniform(sWaterDraw,"uHeight")
uWDpixelDims = shader_get_uniform(sWaterDraw,"texture_Pixel")
_uniUV = shader_get_uniform(sWaterDraw, "u_uv");

pixelDims = shader_get_uniform(sWhiteOutline,"texture_Pixel")

dragitem = noone;
slotLength = 2;
slots = array_create(0);
createItem(0);

state = playerstate.running;
attackstate = playerattackstate.idle;
celebratechange = false;

enum playerstate {
	idle,
	running
}

enum playerattackstate {
	idle,
	attacking,
	hit,
	celebrating
}

function celebrate() {
	attackstate = playerattackstate.celebrating;
	celebratedchange = false;
}