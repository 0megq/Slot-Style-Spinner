extends Control

@export var slot_names: Array[String]
@export var slot_tile_scene: PackedScene

@export var initial_slot_speed: float
@export var slot_deacceleration: float

enum Direction{
	UP = -1,
	DOWN = 1
}

@export var spin_direction:  Direction

var current_slot_speed: float

var slots: Array[SlotTile]

var slot_spinner1: HFlowContainer
var slot_spinner2: HFlowContainer




func _ready() -> void:
	start_spinner(initial_slot_speed)
	
	
func _process(delta: float) -> void:
	if slot_deacceleration * delta > current_slot_speed:
		current_slot_speed = 0
		end_spinner()
	else:
		current_slot_speed -= slot_deacceleration * delta
	
	move_tiles(delta, current_slot_speed, slots, spin_direction)


func end_spinner() -> void:			
	
	
	var closest_slot: SlotTile = slots[0]
	for slot in slots:
		if position.distance_squared_to(slot.position) > position.distance_squared_to(closest_slot.position):
			closest_slot = slot
	
	print(closest_slot.name + " was chosen")
	get_tree().paused = true
	
	
func move_tiles(delta: float, speed: float, slots: Array[SlotTile], direction: Direction) -> void:
	slot_spinner1.position.y += delta * speed * direction
	slot_spinner2.position.y += delta * speed * direction
	
	if abs(slot_spinner1.position.y) > size.y / 2 + slot_spinner1.size.y / 2:
		slot_spinner1.position.y = slot_spinner2.position.y - slot_spinner1.size.y
		
	if abs(slot_spinner2.position.y) > size.y / 2 + slot_spinner1.size.y / 2:
		slot_spinner2.position.y = slot_spinner1.position.y - slot_spinner1.size.y
	
	
	
func start_spinner(slot_start_speed: float) -> void:
	randomize()
	slot_names.shuffle()
	$SlotSpinner.create_tiles(slot_names, slot_tile_scene)
	slot_spinner1 = $SlotSpinner
	slot_spinner2 = $SlotSpinner.duplicate()
	add_child(slot_spinner2)
	
	slots.append_array(slot_spinner1.get_children())
	slots.append_array(slot_spinner2.get_children())
	
	
	call_deferred("set_slot2_position")
	
	current_slot_speed = slot_start_speed
	
	
func set_slot2_position() -> void:
	slot_spinner2.position.y = slot_spinner1.position.y - slot_spinner1.size.y
