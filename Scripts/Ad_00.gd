extends Node2D

export var ad_number:int = 0

onready var timer = $Timer
onready var sprite = $Sprite

var loading_prev = false
var textures_prev = []
var screen_time:float = 10.0
var current_image_index:int = 0
var main

func _ready():
	main = get_parent().get_parent()

func my_turn():
	# load_next_image()
	self.visible = true
	timer.start(screen_time)

func load_next_image():
	loading_prev = false
	var textures = []
	var dir = Directory.new()
	if dir.open(main.get_ad_dir(ad_number)) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
			else:
				if file_name.to_lower().ends_with(".png") or file_name.to_lower().ends_with(".jpg"):
					textures.append(load_image(main.get_ad_dir(ad_number) + file_name))
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Failed to open directory: " + main.get_ad_dir(ad_number))
	if textures.size() <= current_image_index + 1:
		current_image_index = 0
	else:
		current_image_index += 1
	textures_prev = textures
	sprite.texture = textures[current_image_index]

func load_prev_image():
	var textures = textures_prev
	# var dir = Directory.new()
	# if dir.open(main.get_ad_dir(ad_number)) == OK:
	# 	dir.list_dir_begin()
	# 	var file_name = dir.get_next()
	# 	while file_name != "":
	# 		if dir.current_is_dir():
	# 			pass
	# 		else:
	# 			if file_name.to_lower().ends_with(".png") or file_name.to_lower().ends_with(".jpg"):
	# 				textures.append(load_image(main.get_ad_dir(ad_number) + file_name))
	# 		file_name = dir.get_next()
	# 	dir.list_dir_end()
	# else:
	# 	print("Failed to open directory: " + main.get_ad_dir(ad_number))
	if loading_prev:
		current_image_index -= 1
		if current_image_index < 0:
			current_image_index = textures.size() - 1
		sprite.texture = textures[current_image_index]

	else:
		loading_prev = true

func load_image(file_path:String):
	var image = Image.new()
	var error = image.load(file_path)
	if error == OK:
		var texture = ImageTexture.new()
		texture.create_from_image(image)
		return texture
	else:
		return null

func set_screen_time(new_time:float):
	screen_time = new_time

func next():
	self.visible = false
	timer.stop()
	main.next_screen()

func prev():
	self.visible = false
	timer.stop()
	main.prev_screen()

func _on_Timer_timeout():
	loading_prev = false
	next()
