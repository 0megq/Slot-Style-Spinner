extends Control
	
	
func create_tiles(slot_names: Array[String], slot_tile_scene: PackedScene) -> void:
	var slots: Array[SlotTile]
	for slot_name in slot_names:
		var slot: Node = slot_tile_scene.instantiate()
		slot.name = slot_name
		slot.get_node("Name").text = slot_name
		add_child(slot)
		slots.append(slot)

	
	
	
