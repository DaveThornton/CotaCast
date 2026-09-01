extends Node2D

onready var draft_screen = $Screen_00_Draft
onready var tall_screen = $Screen_01_Tall
onready var picture_screen = $Screen_02_Picture
onready var special_screen = $Screen_03_Special

var current_screen:int = 0
var screen_order = [0]

func _ready():
	next_screen()

func next_screen():
	load_settings()
	current_screen += 1
	if current_screen >= screen_order.size():
		current_screen = 0
	get_screen(int(screen_order[current_screen])).my_turn()

func _input(event):
	if event.is_action_pressed("Escape"):
		get_tree().quit()

func load_csv(file_path:String,line_count:int = 1):
	var file = File.new()
	if file.file_exists(file_path):
		var return_list = []
		file.open(file_path, File.READ)
		for _i in range(line_count):
			return_list.append(file.get_csv_line())
		file.close()
		return return_list
	else:
		pass

func load_settings():
	var file = File.new()
	if file.file_exists("res://settings.cfg"):
		file.open("res://settings.cfg", File.READ)
		for _i in range(20):
			var line = file.get_csv_line("=")
			if line == null:
				print("Reached end of settings file.")
				break
			elif line[0] == "screen_order":
				screen_order = line[1].split(",")
			elif line[0] == "picture_time":
				picture_screen.set_screen_time(float(line[1]))
			elif line[0] == "special_time":
				special_screen.set_screen_time(float(line[1]))
			elif line[0] == "draft_time":
				draft_screen.set_screen_time(float(line[1]))
			elif line[0] == "tall_time":
				tall_screen.set_screen_time(float(line[1]))
			elif line[0] == "## Settings":
				pass
			else:
				print("Unknown setting: " + line[0])
		file.close()

func get_screen(screen_index:int) -> Node2D:
	match screen_index:
		0:return draft_screen
		1:return tall_screen
		2:return picture_screen
		3:return special_screen
		_:return draft_screen
