var _dt = delta_time/1000000

x+=addx*_dt
y+=addy*_dt

addy+=_dt*300
life-=_dt
alpha*=.9

if(life<=0) instance_destroy();

draw_set_font(tsDmg)
draw_text_color(x,y,dmg,c_red,c_red,c_red,c_red,alpha)