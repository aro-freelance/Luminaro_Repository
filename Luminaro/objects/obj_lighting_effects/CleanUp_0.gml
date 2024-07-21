/// @description remove the surface when this effect is destroyed


if surface_exists(surface){
    surface_free(surface);
}