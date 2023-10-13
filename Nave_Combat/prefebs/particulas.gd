extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var on_engine = false
export var flame_fail = false


func _ready():
	#Global.allNavs[Global.Nav_select[Global.id]]["Coeficiente"]
	$Particles2D.hue_variation = Global.allNavs[Global.Nav_select[Global.id]].color_machine

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flame_fail:
		$Particles2D.lifetime = 2
		$Particles2D.speed_scale = 3.59
		$Particles2D.explosiveness = 0.49
		$Particles2D.gravity.y = 80
		$Particles2D.color = Color(0.388235, 0.137255, 0.015686, 0.556863)
	else:
		$Particles2D.lifetime = 1.5
		$Particles2D.speed_scale = 3
		$Particles2D.explosiveness = 0
		$Particles2D.gravity.y = 200*(Global.nave.Coeficiente/2)
		$Particles2D.color = Color(1, 1, 1, 1)
	$Particles2D.emitting = on_engine

