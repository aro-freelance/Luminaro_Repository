
if(global.game_state == E_GAME_STATE.PLAYING){

var spr = object_get_sprite(object_index);
if (sprite_index != spr)
{
    sprite_index = spr;
	mask_index = spr;
}


#region Destroy Because Holder Collision Ended



if(bounce_beam1 != noone){
	if(bounce_beam1.holder != noone){
		
		if(array_length(scr_get_obj_collision_point(bounce_beam1.x, bounce_beam1.y, bounce_beam1.holder)) != 2){
		//if(!collision_point(array_get(bounce_beam1.bounce_point, 0), array_get(bounce_beam1.bounce_point, 1), obj_mirror, 0, 0 )){
		//if(!place_meeting(x, y, bounce_beam1.holder)){
			show_debug_message("reset beam 1");
			bounce_beam1 = noone;
			bounce_counter--;
		}
	}
}
if(bounce_beam2 != noone){
	if(bounce_beam2.holder != noone){
		if(!place_meeting(x, y, bounce_beam2.holder)){
			bounce_beam2 = noone;
		}
	}
}
if(bounce_beam3 != noone){
	if(bounce_beam3.holder != noone){
		if(!place_meeting(x, y, bounce_beam3.holder)){
			bounce_beam3 = noone;
		}
	}
}
if(bounce_beam4 != noone){
	if(bounce_beam4.holder != noone){
		if(!place_meeting(x, y, bounce_beam4.holder)){
			bounce_beam4 = noone;
		}
	}
}
if(bounce_beam5 != noone){
	if(bounce_beam5.holder != noone){
		if(!place_meeting(x, y, bounce_beam5.holder)){
			bounce_beam5 = noone;
		}
	}
}

if(holder != noone){
	if(light_type == E_LIGHT_TYPES.MIRROR_BEAM){
		if(array_length(scr_get_obj_collision_point(x, y, holder)) != 2){
		//if(!collision_point(array_get(bounce_point, 0), array_get(bounce_point, 1), obj_light_beam, 0, true )){
		//if(!place_meeting(x, y, holder)){
			
			show_debug_message("destroy self " + string(self));
			instance_destroy();
		}
	}
}


#endregion


#region Change Facing Direction

if(light_type != E_LIGHT_TYPES.MIRROR_BEAM){
	if(holder != noone){
		if(holder == global.player){
			if (holder.facing == E_FACING.left){
			    x_offset = -hold_distance;
			} else {
			     x_offset = hold_distance;
			}
		}
		else{
			x_offset = 0;
		}
	
	
		x = holder.x + x_offset;
		y = holder.y - sprite_get_height(holder.sprite_index)/2;
	
		//show_debug_message("lantern x = " + string(x) + ". y = " + string(y));
	
	
	}
}

#endregion


#region Initial Bounce



if(is_on && can_bounce){
		var max_length = sprite_get_width(sprite_index) * image_xscale;
		//show_debug_message("light step: bounce: max length = " + string(max_length));
		
		
		for (var i = 0; i < max_length; i++ ) {
			xEnd = x + lengthdir_x(i, image_angle);
			yEnd = y + lengthdir_y(i, image_angle);
			
			//if(i = (max_length-1)) show_debug_message("obj_light step: maxlength xend = " + string(xEnd) + ". yend = " + string(yEnd));
		
			 if (collision_point(xEnd, yEnd, obj_mirror, 0, 0 ) ) {
				 
				 
				  if((bounce_counter < bounce_number)){
					bounce_counter++;
				 
				
					if(bounce_counter == 1){
						if(bounce_beam1 == noone){
							show_debug_message("bounce beam 1 spawn. i = " + string(i) + ". x = " + string(xEnd) + ". y = " + string(yEnd));
		
							//mirror.beam = instance_create_layer(mirror.x, mirror.y, "Weapons", obj_light_beam);
							bounce_beam1 = instance_create_layer(xEnd, yEnd, "Weapons", obj_light_beam);
							bounce_beam1.holder = self;
							bounce_beam1.bounce_point = [xEnd, yEnd];
							bounce_beam1.light_type = E_LIGHT_TYPES.MIRROR_BEAM;
							bounce_beam1.is_on = true;
							bounce_beam1.can_bounce = false;
							if(holder.facing == E_FACING.left) bounce_beam1.image_angle = image_angle - 90; //TODO: make a script to set the angle based on the parent beam
							else bounce_beam1.image_angle = image_angle + 90;
							
							break;
						}
						else{
							bounce_beam1.image_angle = image_angle - 90;
							bounce_beam1.x = xEnd;
							bounce_beam1.y = yEnd;
						}
					}
					else if(bounce_counter == 2){
						if(bounce_beam2 == noone){
							show_debug_message("bounce beam 2 spawn. i = " + string(i));
						
							//mirror.beam = instance_create_layer(mirror.x, mirror.y, "Weapons", obj_light_beam);
							bounce_beam2 = instance_create_layer(bounce_beam1.xEnd, bounce_beam1.yEnd, "Weapons", obj_light_beam);
							bounce_beam2.holder = self;
							bounce_beam2.bounce_point = [xEnd, yEnd];
							bounce_beam2.light_type = E_LIGHT_TYPES.MIRROR_BEAM;
							bounce_beam2.is_on = true;
							bounce_beam2.can_bounce = false;
							bounce_beam2.image_angle = bounce_beam1.image_angle - 90;
							break;
						}
						else{
							bounce_beam2.image_angle = bounce_beam1.image_angle - 90;
							bounce_beam2.x = bounce_beam1.xEnd;
							bounce_beam2.y = bounce_beam1.yEnd;
						}
					}
					else if(bounce_counter == 3){
						if(bounce_beam3 == noone){
							show_debug_message("bounce beam 3 spawn. i = " + string(i));
						
							//mirror.beam = instance_create_layer(mirror.x, mirror.y, "Weapons", obj_light_beam);
							bounce_beam3 = instance_create_layer(bounce_beam2.xEnd, bounce_beam2.yEnd, "Weapons", obj_light_beam);
							bounce_beam3.holder = self;
							bounce_beam3.bounce_point = [xEnd, yEnd];
							bounce_beam3.light_type = E_LIGHT_TYPES.MIRROR_BEAM;
							bounce_beam3.is_on = true;
							bounce_beam3.can_bounce = false;
							bounce_beam3.image_angle = bounce_beam2.image_angle - 90;
							break;
						}
						else{
							bounce_beam3.image_angle = bounce_beam2.image_angle - 90;
							bounce_beam3.x = bounce_beam2.xEnd;
							bounce_beam3.y = bounce_beam2.yEnd;
						}
					} 
					else if(bounce_counter == 4){
						if(bounce_beam4 == noone){
							show_debug_message("bounce beam 4 spawn. i = " + string(i));
						
							//mirror.beam = instance_create_layer(mirror.x, mirror.y, "Weapons", obj_light_beam);
							bounce_beam4 = instance_create_layer(bounce_beam3.xEnd, bounce_beam3.yEnd, "Weapons", obj_light_beam);
							bounce_beam4.holder = self;
							bounce_beam4.bounce_point = [xEnd, yEnd];
							bounce_beam4.light_type = E_LIGHT_TYPES.MIRROR_BEAM;
							bounce_beam4.is_on = true;
							bounce_beam4.can_bounce = false;
							bounce_beam4.image_angle = bounce_beam3.image_angle - 90;
							break;
						}
						else{
							bounce_beam4.image_angle = bounce_beam3.image_angle - 90;
							bounce_beam4.x = bounce_beam3.xEnd;
							bounce_beam4.y = bounce_beam3.yEnd;
						}
					} 
					else if(bounce_counter == 5){
						if(bounce_beam5 == noone){
							show_debug_message("bounce beam 5 spawn. i = " + string(i));
						
							//mirror.beam = instance_create_layer(mirror.x, mirror.y, "Weapons", obj_light_beam);
							bounce_beam5 = instance_create_layer(bounce_beam4.xEnd, bounce_beam4.yEnd, "Weapons", obj_light_beam);
							bounce_beam5.holder = self;
							bounce_beam5.bounce_point = [xEnd, yEnd];
							bounce_beam5.light_type = E_LIGHT_TYPES.MIRROR_BEAM;
							bounce_beam5.is_on = true;
							bounce_beam5.can_bounce = false;
							bounce_beam5.image_angle = bounce_beam4.image_angle - 90;
							break;
						}
						else{
							bounce_beam5.image_angle = bounce_beam4.image_angle - 90;
							bounce_beam5.x = bounce_beam4.xEnd;
							bounce_beam5.y = bounce_beam4.yEnd;
						}
					} 
				
				 }
				 //not a new bounce, if there are current beams update them
				 else{
					 
					 
					 #region Update Bounce Beams


					if(bounce_beam1 != noone){
						if(bounce_beam1.is_on){
							show_debug_message("bounce beam 1 movement. x = " + string(xEnd) + ". y = " + string(yEnd));
							bounce_beam1.image_angle = image_angle - 90;
							bounce_beam1.x = xEnd;
							bounce_beam1.y = yEnd;
						}
					}
					if(bounce_beam2 != noone){
						if(bounce_beam2.is_on){
							show_debug_message("bounce beam 2 movement");
							bounce_beam2.image_angle = bounce_beam.image_angle - 90;
							bounce_beam2.x = bounce_beam.xEnd;
							bounce_beam2.y = bounce_beam.yEnd;
						}
					}
					if(bounce_beam3 != noone){
						if(bounce_beam3.is_on){
							show_debug_message("bounce beam 3 movement");
							bounce_beam3.image_angle = bounce_beam2.image_angle - 90;
							bounce_beam3.x = bounce_beam2.xEnd;
							bounce_beam3.y = bounce_beam2.yEnd;
						}
					}
					if(bounce_beam4 != noone){
						if(bounce_beam4.is_on){
							show_debug_message("bounce beam 4 movement");
							bounce_beam4.image_angle = bounce_beam3.image_angle - 90;
							bounce_beam4.x = bounce_beam3.xEnd;
							bounce_beam4.y = bounce_beam3.yEnd;
						}
					}
					if(bounce_beam5 != noone){
						if(bounce_beam5.is_on){
							show_debug_message("bounce beam 5 movement");
							bounce_beam5.image_angle = bounce_beam4.image_angle - 90;
							bounce_beam5.x = bounce_beam4.xEnd;
							bounce_beam5.y = bounce_beam4.yEnd;
						}
					}

					#endregion
					 
					 
					 
					 
				 
				 }
				
				
				
				/*
				var mirror = instance_place(x, y, obj_mirror);
			 
				if(mirror.beam == noone){
				
					show_debug_message("light step: bounce: create beam");
				
					//make the beam
					//mirror.beam = instance_create_layer(mirror.x, mirror.y, "Weapons", obj_light_beam);
					mirror.beam = instance_create_layer(xEnd, yEnd, "Weapons", obj_light_beam);
					mirror.beam.holder = mirror;
					mirror.beam.light_type = E_LIGHT_TYPES.MIRROR_BEAM;
				}
				else{
					show_debug_message("move beam");
					//show_debug_message("light step: bounce: move beam. x = " + string(mirror.beam.x) + ". y = " + string(mirror.beam.y) + ". point x =" + string(array_get(point, 0)) + ". point y = " + string(array_get(point, 1)) );
					mirror.beam.x = xEnd;
					mirror.beam.y = yEnd;
				}
				
			 
			 }
			 //else show_debug_message("no collision =============");
			 
			 
		}
		
		
		
		
		
		
		if(place_meeting(x, y, obj_mirror)){
			bounce_counter++;
			
			var mirror = instance_place(x, y, obj_mirror);
			
			var point = scr_get_obj_collision_point(x, y, mirror);
			
			
			
			for (var i = 0; i < max_length; i++ ) {

			xEnd = x + lengthdir_x(i, direction);
			yEnd = y + lengthdir_y(i, direction);
   
			length_laser = i;   // how long the laser is in the end
   
			// breaking point change here object to break to or add multiple breaking points
			if (collision_point(xEnd, yEnd, obj_Wall_Horizontal,0,0 ) ) {
				//do stuff
			}
			
			
			
			
			/*
			
			//top left
			if(bbox_left < holder.bbox_left && bbox_bottom < holder.bbox_bottom){
				//show_debug_message("top left");
				var point = [bbox_left, bbox_top];
			}
			//top right
			else if(bbox_right > holder.bbox_right && bbox_bottom < holder.bbox_bottom){
				//show_debug_message("top right");
				var point = [bbox_right , bbox_top];
			}
			//bottom left
			else if(bbox_left < holder.bbox_left && bbox_top > holder.bbox_top){
				//show_debug_message("bottom left");
				var point = [bbox_left , bbox_bottom];
			}
			//bottom right
			else if(bbox_right > holder.bbox_right && bbox_top > holder.bbox_top){
				//show_debug_message("bottom right");
				var point = [bbox_right , bbox_bottom];
			}
			else{
				var point = [];
			}
			
			
			
			//show_debug_message("collision with mirror. bounce counter = " + string(bounce_counter) + ". point = " + string(point));
			if(array_length(point) == 2){
				if(mirror.beam == noone){
				
			//		show_debug_message("light step: bounce: create beam");
				
					//make the beam
					//mirror.beam = instance_create_layer(mirror.x, mirror.y, "Weapons", obj_light_beam);
					mirror.beam = instance_create_layer(array_get(point, 0), array_get(point, 1), "Weapons", obj_light_beam);
					mirror.beam.holder = mirror;
					mirror.beam.light_type = E_LIGHT_TYPES.MIRROR_BEAM;
				}
				else{
					//show_debug_message("light step: bounce: move beam. x = " + string(mirror.beam.x) + ". y = " + string(mirror.beam.y) + ". point x =" + string(array_get(point, 0)) + ". point y = " + string(array_get(point, 1)) );
					mirror.beam.x = array_get(point, 0)
					mirror.beam.y = array_get(point, 1)
				}
			}
			
			
		*/
		
		/*
		
			if(mirror.beam == noone){
				//make the beam
				mirror.beam = instance_create_layer(mirror.x, mirror.y, "Weapons", obj_light_beam);
				mirror.beam.image_angle = global.player.beam.image_angle - 90;
				mirror.beam.is_on = true;
			}
			else{
				mirror.beam.image_angle = global.player.beam.image_angle - 90;
				show_debug_message("beam exists. angle = " + string(mirror.beam.image_angle));
			}
		*/
			//#YELSA YOU ARE HERE
			// current plan is make a new beam 
			// set its angle be a reflection of the angle the original beam hit the mirror.
			//set its x scale ? or have it be the same length as the original?
			// in general should the x scale of the beam go up? could start it short and have it go up to a certain length?
			// could also have it's alpha fade at the end? and potency fade based on distance from player?
		
			//also when done here... the enemy projectile collision with solid obj needs bounce functionality.
			//and beam collision with solid obj should hide the rest of the beam after collision? for this use draw_sprite_part
		
		
			/*
			var surface = instance_place(x, y, obj_mirror);
		
			if (direction<surface.direction){
			    direction=direction+(180-(180-(abs(surface.direction-direction)*2)))
			}
			else{
			    direction=direction+(180-(180-(abs((surface.direction+360)-direction)*2)))
			}
		*/
		
		
		}
		
		
		
	}
}

	

//reset the bounce counter if not in contact with a mirror
if(bounce_counter > 0){
	if(!is_on){
		bounce_counter = 0;
		bounce_beam1 = noone;
		bounce_beam2 = noone;
		bounce_beam3 = noone;
		bounce_beam4 = noone;
		bounce_beam5 = noone;
		//show_debug_message("END collision with mirror. reset bounce counter");
	}
}

#endregion









}