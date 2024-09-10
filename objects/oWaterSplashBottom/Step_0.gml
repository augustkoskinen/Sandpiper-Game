image_index = spriteind;
image_alpha = min(timer/timermax,alphamax);
image_xscale = ((timermax-timer)*ripplemax+1);
image_yscale = ((timermax-timer)*ripplemax+1);

timer-=delta_time/1000000;