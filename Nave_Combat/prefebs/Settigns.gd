extends Control


# Declare member variables here. Examples:
# var a = 2
var grap = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventScreenDrag and grap == true :
		
		if int(event.position.x) <= 311 and int(event.position.x) >= 231:
			$Popup/Control.rect_position.x = int(event.position.x)

			$Popup/TextureRect2/TextureProgress.value = (231 *100)/311



   # Print the size of the viewport.
  # print("Viewport Resolution is: ", get_viewport_rect().size)  

func _on_Settigns_pressed():
	$Popup.show()


func _on_Control_mouse_entered():
	grap = true


func _on_Control_mouse_exited():
	grap = false
