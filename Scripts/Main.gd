extends Node2D

onready var beer_lists = $Beer
onready var ads = $Ad
onready var drink_lists = $Drink

var current_screen:int = 0
var screen_order = ["a0","b0","a1","b1","a2","b2","a3","b3","a4","b4","a5","b5"]
var current_scene_node:Node2D = null

func _ready():
	next_screen()

func next_screen():
	load_settings()
	current_screen += 1
	if current_screen >= screen_order.size():
		current_screen = 0
	var scene = get_scene(screen_order[current_screen])
	current_scene_node = scene
	scene.my_turn()


func _input(event):
	if event.is_action_pressed("Escape"):
		get_tree().quit()
	elif event.is_action_pressed("Next"):
		current_scene_node._on_Timer_timeout()

func load_csv(file_path:String):
	var file = File.new()
	if file.file_exists(file_path):
		var return_list = []
		var settings_set = false
		file.open(file_path, File.READ)
		for _i in range(1000):
			var line = file.get_csv_line(",")
			if line == null:
				print("Reached end of CSV file.")
				break
			elif line[0] == "##":
				pass
			elif line[0] == "$$":
				if not settings_set:
					print("Settings line found: " + str(line))
					settings_set = true
					line.remove(0)
					return_list.insert(0, line)
				else:
					print("Settings already set, ignoring line: " + str(line))
					print("only one settings line is allowed per CSV file.")
			else:
				return_list.append(line)
		file.close()
		return return_list
	else:
		return []

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
				print("Screen order set to: " + str(screen_order))
			elif line[0] == "##":
				pass
			elif line[0] == "ad_00_time":
				ads.get_child(0).set_screen_time(float(line[1]))
			elif line[0] == "ad_01_time":
				ads.get_child(1).set_screen_time(float(line[1]))
			elif line[0] == "ad_02_time":
				ads.get_child(2).set_screen_time(float(line[1]))
			elif line[0] == "ad_03_time":
				ads.get_child(3).set_screen_time(float(line[1]))
			elif line[0] == "ad_04_time":
				ads.get_child(4).set_screen_time(float(line[1]))
			elif line[0] == "ad_05_time":
				ads.get_child(5).set_screen_time(float(line[1]))
			else:
				print("Unknown setting: " + line[0] + str(_i))
		file.close()

func get_scene(scene:String) -> Node2D:
	match scene:
		"a0":return ads.get_child(0)
		"a1":return ads.get_child(1)
		"a2":return ads.get_child(2)
		"a3":return ads.get_child(3)
		"a4":return ads.get_child(4)
		"a5":return ads.get_child(5)
		"b0":return beer_lists.get_child(0)
		"b1":return beer_lists.get_child(1)
		"b2":return beer_lists.get_child(2)
		"b3":return beer_lists.get_child(3)
		"b4":return beer_lists.get_child(4)
		"b5":return beer_lists.get_child(5)
		"d0":return drink_lists.get_child(0)
		"d1":return drink_lists.get_child(1)
		"d2":return drink_lists.get_child(2)
		"d3":return drink_lists.get_child(3)
		"d4":return drink_lists.get_child(4)
		"d5":return drink_lists.get_child(5)
		_:return ads.get_child(0)

func get_ad_dir(ad_number:int) -> String:
	match ad_number:
		0: return "res://GFX/Ads/ad_00/"
		1: return "res://GFX/Ads/ad_01/"
		2: return "res://GFX/Ads/ad_02/"
		3: return "res://GFX/Ads/ad_03/"
		4: return "res://GFX/Ads/ad_04/"
		5: return "res://GFX/Ads/ad_05/"
		_: return "res://GFX/Ads/ad_00/"

func get_beer_list(beer_number:int) -> String:
	match beer_number:
		0: return "res://CSV/beer_list_00.csv"
		1: return "res://CSV/beer_list_01.csv"
		2: return "res://CSV/beer_list_02.csv"
		3: return "res://CSV/beer_list_03.csv"
		4: return "res://CSV/beer_list_04.csv"
		5: return "res://CSV/beer_list_05.csv"
		_: return "res://CSV/beer_list_00.csv"

func get_drink_list(drink_number:int) -> String:
	if drink_number <= 100 && drink_number >= 0:
		return "res://CSV/Drink_00.csv"
	elif drink_number < 10 && drink_number >= 0:
		return "res://CSV/Drink_0" + str(drink_number) + ".csv"
	else:
		return "res://CSV/Drink_" + str(drink_number) + ".csv"

func get_ad_scene(ad_number:int) -> Node2D:
	var ad_screen = ads.get_child(ad_number)
	if ad_screen != null:
		return ad_screen
	else:
		print("Ad screen not found for ad number: " + str(ad_number))
		return ads.get_child(0)

func get_beer_list_scene(beer_number:int) -> Node2D:
	var beer_screen = beer_lists.get_child(beer_number)
	if beer_screen != null:
		return beer_screen
	else:
		print("Beer screen not found for beer number: " + str(beer_number))
		return beer_lists.get_child(0)

func get_drink_list_scene(drink_number:int) -> Node2D:
	var drink_screen = drink_lists.get_child(drink_number)
	if drink_screen != null:
		return drink_screen
	else:
		print("Drink screen not found for drink number: " + str(drink_number))
		return drink_lists.get_child(0)
