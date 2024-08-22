scuttleTime = 0;
scuttlex = 0;
scuttlexmax = 0;
scuttlexmin = 0;
scuttleSpeed = 100;

rundir = -1;
driftTime = 0;
driftx = 0;
drifty = 0;
driftSpeed = 20;


driftTime = random_range(1,2);

var dir = random_range(0,359)
driftx = lengthdir_x(driftSpeed, dir)
drifty = lengthdir_y(driftSpeed, dir)
