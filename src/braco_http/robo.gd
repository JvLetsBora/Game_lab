extends Spatial

# Called every frame. 'delta' is the elapsed time since the previous frame.ve_to(a)
var a = 0
var b = 0
var c = 0
var velocidade = 200
var join = ""
var p 
var sentidoC
var sentidoB
var sentidoA

export var fim = false

func _process(delta):
	
	if a + p[0] > 0:
		sentidoA = 1
	else:
		sentidoA = -1

	if b + p[1] > 0:
		sentidoB = 1
	else:
		sentidoB = -1

	if c + p[2] > 0:
		sentidoC = 1
	else:
		sentidoC = -1
	
	if a != p[0]:
		a += (velocidade*delta)*sentidoA
	if b != p[1]:
		b += (velocidade*delta)*sentidoB
	if c != p[2]:
		c += (velocidade*delta)*sentidoC
	
	if join == "C":
		$ant_base.rotation_degrees = Vector3(a,b,c)
		if a >= p[0] and b >= p[1] and c >= p[2]:
			 a = p[0]
			 b = p[1]
			 c = p[2]
			 set_process(false)
			 fim = true

	if join == "B":
		$ant_base/ant_arm2.rotation_degrees = Vector3(a,b,c)
		if a >= p[0] and b >= p[1] and c >= p[2]:
			 a = p[0]
			 b = p[1]
			 c = p[2]
			 set_process(false)
			 fim = true

	if join == "A":
		$ant_base/ant_arm2/arm.rotation_degrees = Vector3(a,b,c)
		if a >= p[0] and b >= p[1] and c >= p[2]:
			 a = p[0]
			 b = p[1]
			 c = p[2]
			 set_process(false)
			 fim = true
	

func move_to(j,posicao):
	join = j
	p = posicao
	set_process(true)
	


