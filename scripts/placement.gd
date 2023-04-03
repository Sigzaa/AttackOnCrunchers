extends Node

@export var starting_money = 100

var Tank = preload("res://towers/tank/TankGhost.tscn")
var WizzardGhost = preload("res://towers/wizzard/WizzardGhost.tscn")
var SniperGhost = preload("res://towers/sniper/SniperGhost.tscn")
var FreezeGhost = preload("res://towers/freeze/FreezeGhost.tscn")



enum SelectedEnum {
  TANK,
  WIZZARD,
  SNIPER,
  FREEZE,
  NONE,
}

var selected = SelectedEnum.NONE

func _ready():
	$HudBar/Panel/Tank.connect("toggled",Callable(self,"_tank_activated"))
	$HudBar/Panel/Freeze.connect("toggled",Callable(self,"_freeze_activated"))
	$HudBar/Panel/Sniper.connect("toggled",Callable(self,"_sniper_activated"))
	$HudBar/Panel/Wizzard.connect("toggled",Callable(self,"_wizzard_activated"))

func _process(delta):
	
	_ghost_selected()
	
func _ghost_selected():
	for ghost in get_tree().get_nodes_in_group("ghost"):
		ghost.position = get_viewport().get_mouse_position()
	


func deselect():
	
	selected = SelectedEnum.NONE
	
	for ghost in get_tree().get_nodes_in_group("ghost"):
		ghost.queue_free()
	
func _instance_sprite(node):
	var ghost_instance = node.instantiate()
	get_parent().add_child(ghost_instance)

func _tank_activated(toggled):
	deselect()
	
	if toggled:
		selected = SelectedEnum.TANK
		_instance_sprite(TankGhost)

func _wizzard_activated(toggled):
	deselect()
	
	if toggled:
		selected = SelectedEnum.WIZZARD
		_instance_sprite(WizzardGhost)
		
func _sniper_activated(toggled):
	deselect()
	
	if toggled:
		selected = SelectedEnum.SNIPER
		_instance_sprite(SniperGhost)
		
		
func _freeze_activated(toggled):
	deselect()
	
	if toggled:
		selected = SelectedEnum.FREEZE
		_instance_sprite(FreezeGhost)
		
		

