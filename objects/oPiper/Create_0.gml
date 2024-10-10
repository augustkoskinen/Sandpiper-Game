//movement vars
RUN_SPEED = 400;
DASH_SPEED = 2000;
dir = 1;
dashvelx = 0;
dashvely = 0;
dashtime = 0;

//sprites
torsoSprite = noone;
torsoInd = 0;
legsSprite = noone;
legsInd = 0;
curInd = 0;
prevLegsInd = 0;
celebratechange = false;

//damage
drownwait = 0;
inDanger = false;
hasAttacked = false
attackspeed = 1.0;
range = 24;
curdamage = 1;
hitcooldown = 0;

//stats
hp = 3;
stamina = 10;
foodPoints = 0;
charge = 0;
chargeMax = 0;
curDepth = 0;

//ticks
rippletick = 0;
ripplecooldown = 0;
splashcooldown = 0;

//shaders
uPercent = shader_get_uniform(sWaterDraw,"uHeight")
uWDpixelDims = shader_get_uniform(sWaterDraw,"texture_Pixel")
_uniUV = shader_get_uniform(sWaterDraw, "u_uv");
pixelDims = shader_get_uniform(sWhiteOutline,"texture_Pixel")

//items
dragitem = noone;
slots = array_create(2,noone);

//slots
state = playerstate.running;
attackstate = playerattackstate.idle;

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