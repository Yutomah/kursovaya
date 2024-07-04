extends LineEdit

@export var a_begin_block:ABeginBlock

@onready var name_label: Label = %NameLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var shema_name = "Блок-схема"
	var i = 0
		
	
	print("\n\n\n")
	
	while true:
		var flag = true
		i+=1
		
		for zone in GB.begin_zones:
			#print(zone.a_begin_block.block_name, " --- ", shema_name + " " + str(i))
			#if zone.a_begin_block.block_name != shema_name + " " + str(i):
				#print("Разные")
				#shema_name = shema_name + " " + str(i)
				#flag = true
				#break
			#else:
				#print("Одинаковые")
			
			if zone.a_begin_block.block_name == shema_name + " " + str(i):
				flag = false
				break
				
		if flag:
			shema_name = shema_name + " " + str(i)
			break
				
	a_begin_block.block_name = shema_name
	name_label.text = shema_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_text_changed(new_text: String) -> void:
	if text != new_text:
		text=new_text
	a_begin_block.block_name = new_text
	name_label.text = new_text
	GB.block_begin_array_changed.emit()
