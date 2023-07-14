extends Node

var pontos = 0
var Jogo_on = true
var nave = {
	"Pos":Vector2(0,0),
	"Coeficiente": 1.20
		}
var dinheiro = 0
var melhorScore = 0
var Nav_select = "Normal"
var scaleMeteoro
var velMeteoro
var fase = null
var vel = 1.1

var go = false

var allNavs = {
	"Normal":{
		"custo":0,
		"Coeficiente": 1.20,
		"poder":9,
		"vida":1
	},
	"Obsidian":{
		"custo":140,
		"Coeficiente": 1.20,
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
		"Coeficiente": 1.20,
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

