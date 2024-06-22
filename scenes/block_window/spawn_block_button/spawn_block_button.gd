extends MenuButton
class_name SpawnBlockButton
signal item_pressed(ablock)

func _ready():
	get_popup().id_pressed.connect(on_id_pressed)
	for i in range(len(GB.ablocks)):
		get_popup().add_item(GB.ablocks[i]["name"])

func on_id_pressed(id:int):
	var ablock = GB.ablocks[id]["scene"].instantiate()
	print(ablock)
	item_pressed.emit(ablock)
	
