extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Line2D.add_point ( Vector2(60,60), 3 )
	$Line2D.add_point ( Vector2(600,600), 1 )


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
