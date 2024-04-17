extends ContextMenu
class_name LoadContextMenu

var loader:Loader

func _ready():
	update_options(loader.get_all_saves())
	
func update_options(saves:Array[String]):
	$VBoxContainer/OptionButton.clear()
	for i in range(saves.size()):
		$VBoxContainer/OptionButton.add_item(saves[i], i)
		

func _on_load_button_pressed():
	if $VBoxContainer/OptionButton.selected != -1:
		var file_name = $VBoxContainer/OptionButton.get_item_text($VBoxContainer/OptionButton.selected)
		loader.load_blocks(file_name)
		close_context_menu()

func _on_delete_button_pressed():
	if $VBoxContainer/OptionButton.selected != -1:
		var file_name = $VBoxContainer/OptionButton.get_item_text($VBoxContainer/OptionButton.selected)
		loader.remove_blocks(file_name)
		close_context_menu()
