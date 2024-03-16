extends AnimatedSprite2D
@onready var player = $".."
var isPlayingAttack1 = false
@onready var animated_sprite_2d = $"."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.is_action_just_pressed("Attack_1") && isPlayingAttack1 == false):
		isPlayingAttack1 = true
		animated_sprite_2d.play("Attack_1")
		await get_tree().create_timer(0.25).timeout
		isPlayingAttack1 = false
	if(player.linear_velocity.x > 0):
		animated_sprite_2d.flip_h = false
	if(player.linear_velocity.x < 0):
		animated_sprite_2d.flip_h = true
	if(player.linear_velocity.x > 0 && player.linear_velocity.y == 0 && isPlayingAttack1 == false):
		animated_sprite_2d.play("run")
	if(player.linear_velocity.x < 0 && player.linear_velocity.y == 0 && isPlayingAttack1 == false):
		animated_sprite_2d.play("run")
	if(player.linear_velocity.x == 0 && player.linear_velocity.y == 0 && isPlayingAttack1 == false):
		animated_sprite_2d.play("Idle")
	if(player.linear_velocity.y < 0 && isPlayingAttack1 == false):
		animated_sprite_2d.play("Jump")
	if(player.linear_velocity.y > 0 && isPlayingAttack1 == false):
		animated_sprite_2d.play("Fall")
	pass
