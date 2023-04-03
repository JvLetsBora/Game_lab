extends CanvasLayer


func _ready():
	$Timer.start()
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$robo.set_process(false)
	$robo.fim = true

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	if json.result:
		if json.result["join"] == "A":
			$textos/A.modulate = Color(0.090196, 0.243137, 0.047059)
			$textos/A.text = "JoinA: "+str(json.result["posicoes"])
			$textos/B.modulate = Color(1, 1, 1)
			$textos/C.modulate = Color(1, 1, 1)
		elif json.result["join"] == "B":
			$textos/B.modulate = Color(0.090196, 0.243137, 0.047059)
			$textos/B.text = "JoinB: "+str(json.result["posicoes"])
			$textos/A.modulate = Color(1, 1, 1)
			$textos/C.modulate = Color(1, 1, 1)
		else:
			$textos/C.modulate = Color(0.090196, 0.243137, 0.047059)
			$textos/C.text = "JoinC: "+str(json.result["posicoes"])
			$textos/A.modulate = Color(1, 1, 1)
			$textos/B.modulate = Color(1, 1, 1)
		$robo.move_to(json.result["join"],json.result["posicoes"])



func _on_Timer_timeout():
	if $robo.fim == true:
		$HTTPRequest.request("http://127.0.0.1:5000/posicao")

