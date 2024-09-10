randomize()

audio_play_sound(Background_Wind, 1, true)

//particles
global.psystem = part_system_create();
global.bloodps = part_type_create()
global.bloodpsem = part_emitter_create(global.psystem)

part_type_sprite(global.bloodps,sBlood,0,0,1);
part_type_size(global.bloodps,.9,2,0,0);
part_type_life(global.bloodps,15,20);
part_type_speed(global.bloodps,2,3,0,0);
part_type_direction(global.bloodps,45,135,0,0);
part_type_gravity(global.bloodps,.3,270)

part_emitter_region(global.psystem, global.bloodpsem, x,x,y,y, ps_shape_ellipse, ps_distr_invgaussian);
part_emitter_relative(global.psystem, global.bloodpsem, true);
part_emitter_stream(global.psystem, global.bloodpsem, global.bloodps, 5);

global.heightto64 = 64*32;