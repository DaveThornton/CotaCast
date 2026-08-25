extends Node2D

onready var draft_screen = $Screen_00_Draft
onready var tall_screen = $Screen_01_Tall
onready var picture_screen = $Screen_02_Picture

var screens:int = 0
var current_screen:int = 0

func _ready():
	screens = self.get_child_count() + 1
	next_screen()

func next_screen():
	current_screen = (current_screen + 1) % screens
	if current_screen >= screens + 1:
		current_screen = 0
	match current_screen:
		0:draft_screen.my_turn()
		1:picture_screen.my_turn()
		2:tall_screen.my_turn()
		3:picture_screen.my_turn()
		_:draft_screen.my_turn()

func _input(event):
	if event.is_action_pressed("Escape"):
		get_tree().quit()

func load_csv(file_path:String,line_count:int = 1):
	var file = File.new()
	if file.file_exists(file_path):
		var return_list = []
		file.open(file_path, File.READ)
		print("File exists: " + file_path)
		for _i in range(line_count):
			return_list.append(file.get_csv_line())
		file.close()
		return return_list
	else:
		print("File does not exist: " + file_path)