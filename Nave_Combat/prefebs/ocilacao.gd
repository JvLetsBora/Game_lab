extends Node2D


# Declare member variables here. Examples:
var a:float = 1
var b:float = 1
var y = 0
var x = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale = Vector2(0.2,0.2)
	self.modulate = Color(1, 1, 1, 0.2)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	x += delta
	y = a*sin(b*x)
	self.position.x -= 250*delta
	self.position.y += (300*delta)*(1+Global.nave.Coeficiente)
	if ( y > 0.2 and y < 0.3):
		self.scale = Vector2(y,y)
		self.modulate = Color(1, 1, 1, y)
	
	
	if(position.x < -378):
		self.position.x = 1000
		self.position.y = -1080
	

