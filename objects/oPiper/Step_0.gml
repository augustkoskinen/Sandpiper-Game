var inputrl = keyboard_check(ord("D"))-keyboard_check(ord("A"))
var inputud = keyboard_check(ord("S"))-keyboard_check(ord("W"))

var movedirection = round(point_direction(0,0,inputrl,inputud))
	
if (inputud==0&&inputrl==0) {
	movedirection = -1
	state = playerstate.idle
	if(dir==1) {
		sprite_index = sPiperR
	} else {
		sprite_index = sPiperL
	}
} else {
	state = playerstate.running
	if(inputrl!=0)
		dir = inputrl;
	
	if(dir==1) {
		sprite_index = sPiperLW
	} else {
		sprite_index = sPiperRW
	}
	
	var xadd = lengthdir_x(RUN_SPEED*delta_time/1000000,movedirection)
	var yadd = lengthdir_y(RUN_SPEED*delta_time/1000000,movedirection)

	x+=xadd
	y+=yadd
}