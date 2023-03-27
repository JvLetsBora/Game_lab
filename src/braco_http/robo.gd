extends Spatial

# Called every frame. 'delta' is the elapsed time since the previous frame.ve_to(a)


func move_to(j,posicao):
	if j == "C":
		if (posicao[0] < 21 and posicao[0] > -21) and (posicao[2]  < 15 and posicao[2]  > -15):
			$ant_base.rotation_degrees = Vector3(posicao[0],0,posicao[2])
	
	if j == "B":
		if (posicao[0] < 120 and posicao[0] > -92) and (posicao[1] < 10 and posicao[1] > -10) and (posicao[2]  < 8 and posicao[2]  > -8):
			$ant_base/ant_arm2.rotation_degrees = Vector3(posicao[0],posicao[1],posicao[2])
	
	if j == "A":
		if (posicao[0] < 116 and posicao[0] > -62) and (posicao[1] < 21 and posicao[1] > -18) and (posicao[2] < 15 and posicao[2]  > -15):
			$ant_base/ant_arm2/arm.rotation_degrees = Vector3(posicao[0],posicao[1],posicao[2])
