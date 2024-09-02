event_inherited();

scuttleSpeed = 80
scuttleTime = random_range(1,3)
scuttlex = irandom_range(1,2)==1?scuttleSpeed:-scuttleSpeed;
var maxmin = random_range(64,128)
scuttlexmax = x+maxmin
scuttlexmin = x-maxmin

chargetime = 0;
chargeSpeed = 150;
chargeX = 0;
chargeY = 0;

state = crabbossstate.scuttling;

enum crabbossstate {
	scuttling,
	charging,
}