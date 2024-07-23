

if(!is_exploding) timer++;

if(timer > time_until_disappear){
	instance_destroy();
}


//this just increases the size. collisions with enemies etc are handled in specific collision events on this obj
if(is_exploding){

	if(sprite_width >= (max_size * global.player.dynamic_catalyst_size_mod) || sprite_height >= (max_size * global.player.dynamic_catalyst_size_mod)){
		instance_destroy();
	} 
	else {
	
		//increase in size until max size over the explosion_duration 
		var rate = (max_size * global.player.dynamic_catalyst_size_mod)/explosion_duration;
	
		image_xscale += rate;
		image_yscale += rate;
	}

}