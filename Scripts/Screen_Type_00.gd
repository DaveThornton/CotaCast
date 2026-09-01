extends Node2D

export var screen_time:float = 60.0
export var list:String
export var list_length:int = 0
onready var list_vbox = $List_vbox
onready var timer = $Timer

func _ready():
	list_length = list_vbox.get_child_count()

func my_turn():
	self.visible = true
	update_list(get_parent().load_csv(list,list_length))
	timer.start(screen_time)

func update_list(long_list:Array):
	list_vbox.update_list(long_list)

func _on_Timer_timeout():
	self.visible = false
	get_parent().next_screen()

func set_screen_time(new_time:float):
	screen_time = new_time
