
//this is used to spawn an enemy
//type input : which enemy type should spawn? using E_ENEMY_TYPES
//location input: array of x, y position where the enemy should spawn


function scr_spawn_boss(type, location, supercharged){
	
	
	if(type == E_BOSS_TYPES.BOSS_1){
		var enemy_obj = obj_enemy_boss_1;
	} 
	else if(type == E_BOSS_TYPES.BOSS_2){
		var enemy_obj = obj_enemy_boss_2;
	}
	else{
		var enemy_obj = obj_enemy_boss_1;
	}
	
	
	var enemy = instance_create_layer(array_get(location, 0), array_get(location, 1), "Actors", enemy_obj);
	
	if(supercharged) enemy.supercharged = true;
	
	ds_list_add(global.enemy_list, enemy);

}