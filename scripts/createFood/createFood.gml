function createFood(type, _x, _y, life) {
	var food = instance_create_depth(_x,_y,-_y,oFood);
	food.life = life;
	food.image_index = type;
}