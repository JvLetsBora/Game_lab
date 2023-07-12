extends Control

var naves_ = []

# Called when the node enters the scene tree for the first time.
func _ready():
	self.dir_contents("res://grafica/Shopping/navs/")
	if !naves_.empty():
		self.insert_navs(naves_)
	print(naves_)
	
	
	


func insert_navs(nvs):
	var soma = 0
	for i in nvs:
		soma +=1
		var new_name = ('nav'+str(soma))
		var a = TextureRect.new()
		var path_nav = str("res://grafica/Shopping/navs/"+i)
		var nav_texture:Texture = load(path_nav)
		a.name = new_name
		a.expand = false
		a.stretch_mode = 6
		a.texture = nav_texture
		a.anchor_bottom = 0.817
		a.anchor_left = 0.285
		a.anchor_top = 0.192
		a.anchor_right = 0.718
		$GDNaves.add_child(a)




func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				var name = String(file_name)
				if name.find("import") == -1 and name != ".DS_Store":
					naves_.append(name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
