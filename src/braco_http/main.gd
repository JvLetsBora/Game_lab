extends CanvasLayer

func _ready():
	$Timer.start()
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	#print(json.result)
	for i in json.result:
		print(i["join"],i["posicoes"])
		$robo.move_to(i["join"],i["posicoes"])



func _on_Timer_timeout():
	$HTTPRequest.request("https://7yc0jq-5000.csb.app/books")
