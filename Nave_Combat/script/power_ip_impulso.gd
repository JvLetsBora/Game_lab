extends "res://script/coletavel.gd"

# Called when the node enters the scene tree for the first time.
var blink_timer := Timer.new()

func _ready():
	pass

func _blink():
	# Inverter o valor da propriedade modulate para alternar entre visível e invisível
	if self.modulate == Color(1, 3.2, 1, 1):
		self.modulate = Color(1, 1, 1, 0)  # Tornar o objeto invisível
	else:
		self.modulate = Color(1, 3.2, 1, 1)  # Tornar o objeto visível

func _process(delta):
	_blink()
	position.y += (vel*delta)+Global.nave.Coeficiente
	area_limite(self,Vector2(90,90))



func _on_Area2D_area_entered(area):
	if area.name == "Nave":
		get_parent().emit_signal("Nave_impulso")
		self.set_deferred("disabled", true)
