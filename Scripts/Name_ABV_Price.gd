extends HBoxContainer

onready var name_label = $Name_Label
onready var brew_label = $Node2D/Brew_Label
onready var type_label = $Node2D/Type_Label
onready var abv_label = $VBoxContainer/HBoxContainer/ABV_Label
onready var price_label = $VBoxContainer/HBoxContainer/Price_Label

func set_name_abv_price(short_list:Array):
	name_label.text = short_list[0]
	brew_label.text = short_list[1]
	type_label.text = short_list[2]
	if short_list[3] == "":
		abv_label.text = ""
	else:
		abv_label.text = short_list[3] + "%"
	if short_list[4] == "":
		price_label.text = ""
	else:
		price_label.text = "$" + short_list[4]
