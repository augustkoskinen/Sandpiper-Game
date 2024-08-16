if(state==itemState.picked) {
	//if(keyboard_check_pressed(vk_space)) drop(oPiper.x,oPiper.y)
} else if(state==itemState.dropped) {
	if(place_meeting(x,y,oPiper)&&!touchedplayer) {
		pickUp()
	} else if(!place_meeting(x,y,oPiper)){
		touchedplayer = false;
	}
}