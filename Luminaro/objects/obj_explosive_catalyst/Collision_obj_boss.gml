/// @description explosive catalyst collision with boss


if(is_exploding){

	other.dynamic_hp = other.dynamic_hp - damage;
	show_debug_message("catalyst / boss collision. boss hp = " + string(other.dynamic_hp));
}