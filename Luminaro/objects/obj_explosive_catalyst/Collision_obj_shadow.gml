/// @description explosive catalyst collision with spawn shadow


if(is_exploding){

	other.hp = other.hp - damage;
	
	show_debug_message("catalyst / spawn shadow collision. shadow hp = " + string(other.hp));

}