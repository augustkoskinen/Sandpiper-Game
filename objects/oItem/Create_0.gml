state = itemState.dropped;
touchedplayer = false;

enum itemState {
	dropped, 
	picked
}

function pickUp() {
	if(array_length(oPiper.slots) < oPiper.slotLength) {
		array_push(oPiper.slots,self)
		
		visible = false;
		state = itemState.picked;
	}
}

function drop(_x,_y) {
	touchedplayer = true;
	
	x = _x;
	y = _y;
	
	visible = true;
	state = itemState.dropped;
	
	array_delete(oPiper.slots,array_get_index(oPiper.slots,self),1)
}