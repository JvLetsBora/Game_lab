extends Node2D

var vel = 100

var is_shaking = true
var shake_duration = 1.3  # Duração da vibração em segundos
var shake_amplitude = 5.0  # Amplitude da vibração (o quanto a tela vai tremer)

func area_limite(obj,k):
	if(position.y > get_viewport().size.y + k.y or position.x > get_viewport().size.x-(k.x) or position.x < -(k.x)):
		obj.set_deferred("disabled", true)
		queue_free()


func start_shake():
	if is_shaking:
		var random_offset = Vector2(rand_range(-shake_amplitude+self.position.x, shake_amplitude+self.position.x), rand_range(-shake_amplitude+self.position.y, shake_amplitude+self.position.y))
		self.position = random_offset
