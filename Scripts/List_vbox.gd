extends VBoxContainer


func _ready():
	pass # Replace with function body.

func update_list(long_list:Array):
	if long_list.size() >= self.get_child_count():
		for i in self.get_child_count():
			print("Adding new child to list_vbox",long_list[i])
			self.get_child(i).set_name_abv_price(long_list[i])
