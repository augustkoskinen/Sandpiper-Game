var _dt = delta_time/1000000

x+=addx*_dt
y+=addy*_dt

addy*=.9
life-=_dt
alpha*=.96

if(life<=0) instance_destroy();

draw_set_font(tsDmg)
draw_text_transformed_color(x,y,dmg,2,2,0,c_red,c_red,c_red,c_black,alpha)