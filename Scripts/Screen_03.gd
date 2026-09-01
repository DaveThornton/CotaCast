extends Node2D

export var screen_time:float = 10.0

onready var timer = $Timer
onready var sprite = $Sprite

var current_image_index:int = 0

func my_turn():
	load_next_image()
	self.visible = true
	timer.start(screen_time)

func load_next_image():
	var textures = []
	var dir = Directory.new()
	if dir.open("res://GFX/Special/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				if file_name.to_lower().ends_with(".png") or file_name.to_lower().ends_with(".jpg"):
					textures.append(load_image("res://GFX/Special/" + file_name))
			file_name = dir.get_next()
		dir.list_dir_end()
	if textures.size() <= current_image_index + 1:
		current_image_index = 0
	else:
		current_image_index += 1
	sprite.texture = textures[current_image_index]

func load_image(file_path:String):
	var image = Image.new()
	var error = image.load(file_path)
	if error == OK:
		var texture = ImageTexture.new()
		texture.create_from_image(image)
		return texture
	else:
		return null

func _on_Timer_timeout():
	self.visible = false
	get_parent().next_screen()

func set_screen_time(new_time:float):
	screen_time = new_time
