/// @description collide with obj_enemy


//if the light is turned on
if(is_on){
	
	//if it is a lantern
	if(light_type == E_LIGHT_TYPES.LANTERN){
	
		
		other.dynamic_hp = other.dynamic_hp - intensity;
		show_debug_message("obj_light collision obj_enemy: enemy collision with lantern. hp = " + string(other.dynamic_hp));

	}

	//if it is a beam
	if(light_type == E_LIGHT_TYPES.BEAM){
		
		
	
		if(size = E_LIGHT_SIZE.NORMAL){
			other.dynamic_hp = other.dynamic_hp - intensity;
		}
		else if (size = E_LIGHT_SIZE.NARROW){
			other.dynamic_hp = other.dynamic_hp - (intensity * 2);
		}
		else if (size = E_LIGHT_SIZE.WIDE){
			other.dynamic_hp = other.dynamic_hp - (intensity / 2);
		}
		
		show_debug_message("obj_light collision obj_enemy: enemy collision with light beam. hp = " + string(other.dynamic_hp));
		
	}
}

