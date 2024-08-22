RUN_SPEED = 200;
dir = 1;

curDepth  = 0;

torsoSprite = noone;
torsoInd = 0;
legsSprite = noone;
legsInd = 0;

hp = 10;
stamina = 10;
foodPoints = 0;
charge = 0;
chargeMax = 0;

slotLength = 2;
slots = array_create(0);
createItem(0);

state = playerstate.running;
attackstate = playerattackstate.attacking

enum playerstate {
	idle,
	running
}

enum playerattackstate {
	attacking,
	idle
}