extends CanvasLayer


func _ready():
	$Timer.start()
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$robo.set_process(false)
	$robo.fim = true

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result["join"],json.result["posicoes"])
	$robo.move_to(json.result["join"],json.result["posicoes"])



func _on_Timer_timeout():
	if $robo.fim == true:
		$HTTPRequest.request("https://7yc0jq-5000.csb.app/posicao")

