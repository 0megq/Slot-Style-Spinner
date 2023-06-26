extends TextureRect

class_name SlotTile

func is_height_visible(visible_height_size: float, tolerance: float) -> bool:
	var max_distance: float = visible_height_size / 2 + size.y / 2 + tolerance
	
	if max_distance < abs(position.y):
		return false
		
	return true
	
	
