extends Node2D

@onready var globals = get_node("/root/Globals")
@export var max_hp = 80
@export var velocity = 125;

var hp = max_hp; 

var TakeDmg = preload("res://scenes/take_dmg.tscn");

var path_offset = 0; 
var speed_coef = 1;
func take_dmg(amount: int):
	
	hp -= amount;
	var take_dmg = TakeDmg.instantiate();
	take_dmg.dmg = amount;
	add_child(take_dmg);

func _ready():
	$AnimationPlayer.play("Walk")
	
func _process(delta):

	$Board.hp = float(hp)/max_hp;
	if hp <= 0:
		queue_free()
		get_node("../Bank").money += 20
	
	path_offset += delta * speed_coef;
	
	for follow_path in get_tree().get_nodes_in_group("enemy_path"):
		
		#Move
		follow_path.progress = path_offset * velocity;

		global_position = follow_path.position
		#global_position.y += 350;
		pass
		
