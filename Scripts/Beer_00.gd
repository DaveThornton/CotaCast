extends Node2D

export var screen_time:float = 60.0
# export var list:String
export var list_length:int = 0
export var beer_number:int = 0

onready var list_vbox_05 = $List_vbox_05
onready var list_vbox_06 = $List_vbox_06
onready var list_vbox_07 = $List_vbox_07
onready var list_vbox_08 = $List_vbox_08
onready var list_vbox_09 = $List_vbox_09
onready var list_vbox_10 = $List_vbox_10
onready var list_vbox_11 = $List_vbox_11
onready var list_vbox_12 = $List_vbox_12
onready var list_vbox_13 = $List_vbox_13
onready var list_vbox_14 = $List_vbox_14
onready var list_vbox_15 = $List_vbox_15
onready var list_vbox_16 = $List_vbox_16
onready var list_vbox_17 = $List_vbox_17
onready var label = $Label
onready var logo = $Logo
onready var background = $Background

onready var timer = $Timer

var main
var box
func _ready():
	main = get_parent().get_parent()

func my_turn():
	self.visible = true
	update_list(main.load_csv(main.get_beer_list(beer_number)))
	# update_list(main.load_csv(list))

func update_list(long_list:Array):
	vbox_all_out()
	var settings = long_list.pop_front()
	timer.start(float(settings[1]))
	box = get_box(int(settings[0]))
	box.update_list(long_list)
	box.set_color(int(settings[7]),int(settings[8]),int(settings[9]))
	box.visible = true
	# get_box(int(settings[0])).update_list(long_list)
	# get_box(int(settings[0])).set_color(int(settings[8]),int(settings[9]),int(settings[10]))
	# get_box(int(settings[0])).visible = true

	set_logo_number(int(settings[2]))
	set_logo_scale(get_logo_scale(int(settings[0])))
	set_logo_position(get_logo_position(int(settings[0])))

	set_label_scale(get_label_scale(int(settings[0])))
	set_label_position(get_label_position(int(settings[0])))
	set_label_text(settings[3])

	set_background_color(int(settings[4]),int(settings[5]),int(settings[6]))
	set_label_color(int(settings[7]),int(settings[8]),int(settings[9]))
	set_logo_color(int(settings[10]),int(settings[11]),int(settings[12]))

func vbox_all_out():
	for i in range(5,18):
		var this_box = get_box(i)
		if this_box != null:
			this_box.visible = false

func set_screen_time(new_time:float):
	screen_time = new_time

func set_background_color(r:int,g:int,b:int):
	background.color = Color(r,g,b)

func set_label_text(new_text:String):
	label.text = new_text

func set_label_color(r:int,g:int,b:int):
	label.modulate = Color8(r,g,b)

func set_label_scale(new_scale:float):
	label.rect_scale = Vector2(new_scale,new_scale)

func set_label_position(new_position:Vector2):
	label.margin_left = new_position.x
	label.margin_top = new_position.y
	
func set_logo_scale(new_scale:float):
	logo.scale = Vector2(new_scale,new_scale)

func set_logo_color(r:int,g:int,b:int):
	logo.modulate = Color8(r,g,b)

func set_logo_position(new_position:Vector2):
	logo.global_position = new_position

func set_logo_number(logo_number:int):
	logo.texture = load("res://GFX/Logo_0" + str(logo_number) + ".png")

func get_box(index:int) -> VBoxContainer:
	match index:
		5: return list_vbox_05
		6: return list_vbox_06
		7: return list_vbox_07
		8: return list_vbox_08
		9: return list_vbox_09
		10: return list_vbox_10
		11: return list_vbox_11
		12: return list_vbox_12
		13: return list_vbox_13
		14: return list_vbox_14
		15: return list_vbox_15
		16: return list_vbox_16
		17: return list_vbox_17
		# _: return list_vbox_05
		_: return null

func get_logo_scale(number:int) -> float:
	match number:
		5: return 0.85
		6: return 0.85
		7: return 0.85
		8: return 0.85
		9: return 0.65
		10: return 0.65
		11: return 0.5
		12: return 0.4
		13: return 0.3
		14: return 0.3
		15: return 0.2
		16: return 0.01
		17: return 0.01
		_: return 0.85

func get_logo_position(number:int) -> Vector2:
	match number:
		5: return Vector2(540,285)
		6: return Vector2(540,285)
		7: return Vector2(540,285)
		8: return Vector2(540,285)
		9: return Vector2(540,285)
		10: return Vector2(540,285)
		11: return Vector2(540,285)
		12: return Vector2(540,285)
		13: return Vector2(540,285)
		14: return Vector2(140,140)
		15: return Vector2(140,140)
		16: return Vector2(-500,0)
		17: return Vector2(-500,0)
		_: return Vector2(540,0)

func get_label_scale(number:int) -> float:
	match number:
		5: return 1.0
		6: return 1.0
		7: return 1.0
		8: return 1.0
		9: return 1.0
		10: return 1.0
		11: return 1.0
		12: return 1.0
		13: return 1.0
		14: return 0.75
		15: return 0.75
		16: return 0.01
		17: return 0.01
		_: return 1.0

func get_label_position(number:int) -> Vector2:
	match number:
		5: return Vector2(0,744)
		6: return Vector2(0,744)
		7: return Vector2(0,744)
		8: return Vector2(0,744)
		9: return Vector2(0,534)
		10: return Vector2(0,534)
		11: return Vector2(0,440)
		12: return Vector2(0,335)
		13: return Vector2(0,228)
		14: return Vector2(267,78)
		15: return Vector2(267,37)
		16: return Vector2(-500,0)
		17: return Vector2(-500,0)
		_: return Vector2(0,744)

func next():
	self.visible = false
	timer.stop()
	main.next_screen()

func prev():
	self.visible = false
	timer.stop()
	main.prev_screen()

func _on_Timer_timeout():
	next()

func load_next_image():
	pass

func load_prev_image():
	pass
