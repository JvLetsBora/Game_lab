extends Node2D

var vel = 100

func area_limite(obj,k):
	if(position.y > get_viewport().size.y + k.y or position.x > get_viewport().size.x-(k.x) or position.x < -(k.x)):
		obj.set_deferred("disabled", true)
		queue_free()
