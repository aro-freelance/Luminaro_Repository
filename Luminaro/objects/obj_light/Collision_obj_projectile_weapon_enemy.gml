/// @description destroy hit projectiles

if(is_on){
	
	show_debug_message("projectile collides with light");

	instance_destroy(other);
}

