extends "res://script/coletavel.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += (vel*delta)+Global.nave.Coeficiente
	area_limite(self,Vector2(90,90))



func _on_Area2D_area_entered(area):
	if area.name == "Nave":
		get_parent().emit_signal("Nave_impulso")
		self.set_deferred("disabled", true)
