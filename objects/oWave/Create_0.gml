dsList = ds_list_create();

counter = 0;
maxWaitTime = 2000;

audio = true;
curDepth = 6;

crashed = false;
hasCrashed = false;

spd = 400;

state = WAVE_STATE.ROLLING_UP;

x = 200;
y = 2000;

enum WAVE_STATE {
	ROLLING_UP,
	WAITING,
	CRASHING,
	WASHING_OUT
}