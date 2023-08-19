extends Node

const SAVE_GAME_PATH := "res://save.json"

var _file := File.new()

var dinheiro = 880
var pontos = 0
var Jogo_on = true
var nave = {
	"Pos":Vector2(0,0),
	"Coeficiente": 1.20
		}

var Nav_select = ["Spectra"]
var scaleMeteoro
var velMeteoro
var vel = 2.1
var go = false
var id = 0


var allNavs = {
	"Normal":{
		"custo":0,
		"Coeficiente": 1.20,
		"poder":9,
		"vida":1
	},
	"Obsidian":{
		"custo":140,
		"Coeficiente": 1.80,
		"poder":9,
		"vida":1
	},
	"Placeholder":{
		"custo":200,
		"Coeficiente": 1.20,
		"poder":9,
		"vida":1
	},
	"Spectra":{
		"custo":85,
		"Coeficiente": 3.20,
		"poder":9,
		"vida":1
	},
	"Teste":{
		"custo":85,
		"Coeficiente": 1.20,
		"poder":9,
		"vida":1
	}
}






func save_exists() -> bool:
	return _file.file_exists(SAVE_GAME_PATH)

func create_save():
	pass

func write_savegame() -> void:
	var error := _file.open(SAVE_GAME_PATH, File.WRITE)
	if error != OK:
		printerr("Could not open the file %s. Aborting save operation. Error code: %s" % [SAVE_GAME_PATH, error])
		return
	#Dados que seram salvos
	var data := {}
	
	var json_string := JSON.print(data)
	_file.store_string(json_string)
	_file.close()

func load_savegame() -> void:
	var error := _file.open(SAVE_GAME_PATH, File.READ)
	if error != OK:
		printerr("Could not open the file %s. Aborting load operation. Error code: %s" % [SAVE_GAME_PATH, error])
		return

	var content := _file.get_as_text()
	_file.close()

	var _data: Dictionary = JSON.parse(content).result
	#map_name = data.map_name
