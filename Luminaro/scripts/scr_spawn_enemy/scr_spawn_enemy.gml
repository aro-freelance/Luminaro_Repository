
//this is used to spawn an enemy
//type input : which enemy type should spawn? using E_ENEMY_TYPES
//location input: array of x, y position where the enemy should spawn


function scr_spawn_enemy(type, location, supercharged){
	
	//show_debug_message("spawn enemy. type = " + string(type));
	
	if(type == E_ENEMY_TYPES.BIG){
		var enemy_obj = obj_enemy_big;
	} 
	else if(type == E_ENEMY_TYPES.SMALL){
		var enemy_obj = obj_enemy_small;
	}
	else if(type == E_ENEMY_TYPES.TALL){
		var enemy_obj = obj_enemy_tall;
	}
	else if(type == E_ENEMY_TYPES.TINY){
		var enemy_obj = obj_enemy_tiny;
	}
	else{
		var enemy_obj = obj_enemy;
	}
	
	var enemy = instance_create_layer(array_get(location, 0), array_get(location, 1), "Actors", enemy_obj);
	
	if(supercharged) enemy.supercharged = true;
	
	ds_list_add(global.enemy_list, enemy);

}