extends Control


var y = 0
var x = 0
var continua = true
# Called when the node enters the scene tree for the first time.
func _ready():
	y = 0
	x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (x < 0.24) and continua == true:
		$ColorRect.color = Color((y-x), y, x)
		y = x*2
		x += 0.2*delta 

	else:
		continua = false
		if x != 0:
			$ColorRect.color = Color((y-x), y, x)
			y = 2*x
			x -= 0.2*delta
	if continua == false and x <= 0:
		get_tree().change_scene("res://scenes/Inicio.tscn")
