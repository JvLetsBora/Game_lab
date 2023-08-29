extends Area2D

export var balaVel = 1000
var bateu = false
signal bateu


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimaTiro.animation = "normal"



func _process(delta):
	if(position.y < -830 ):
		queue_free()
	if(bateu == false):position.y -= balaVel*delta



func _on_Tiro_c_bateu():
	bateu = true
	$TiroArea.set_deferred("disabled", true)
	$AnimaTiro.animation = "explodi"
	yield(get_tree().create_timer(0.1),"timeout")
	queue_free()


func _on_Tiro_c_area_entered(area):
	if(area.name != "Nave" ):
		emit_signal("bateu")
