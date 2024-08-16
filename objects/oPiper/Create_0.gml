RUN_SPEED = 200;
dir = 1;

foodPoints = 0;
charge = 0;
chargeMax = 0;

slotLength = 2;
slots = array_create(0);
createItem(0);

state = playerstate.running;

enum playerstate {
	idle,
	running
}