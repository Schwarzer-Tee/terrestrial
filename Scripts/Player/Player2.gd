extends RigidBody2D

@onready var ground_cast = $GroundCast
var startedJump = false
var speed = 400
@onready var animated_sprite_2d = $AnimatedSprite2D
var isPlayingAttack1 = false
@onready var left_arm = $Left_Arm
@onready var right_arm = $Right_Arm
@onready var player = $"."
var hitmultiplyer = 1
var hitstrengh = 300
var hitstun = false

func _process(delta):
	
	if(hitstun == true):
		await get_tree().create_timer(0.3).timeout
		hitstun = false
	
	if(linear_velocity.x > 0):
		linear_velocity.x += -1200 * delta
		if(linear_velocity.x != 0 && linear_velocity.x < 0):
			linear_velocity.x = 0
	if(linear_velocity.x < 0):
		linear_velocity.x += 1200 * delta
		if(linear_velocity.x != 0 && linear_velocity.x > 0):
			linear_velocity.x = 0
	
	if(linear_velocity.y < 800):
		linear_velocity.y += 700 * delta
	if(startedJump == false && ground_cast.is_colliding()):
		linear_velocity.y = 0
	
	if(Input.is_action_pressed("right") && hitstun == false):
		if(linear_velocity.x + speed > speed):
			linear_velocity.x = speed
		else:
			linear_velocity.x += speed
	if(Input.is_action_pressed("left") && hitstun == false):
		if(linear_velocity.x + -speed < -speed):
			linear_velocity.x = -speed
		else:
			linear_velocity.x += -speed
	if(Input.is_action_just_pressed("up") && ground_cast.is_colliding()):
		linear_velocity.y -= 500 
		startedJump = true
		await get_tree().create_timer(0.1).timeout
		startedJump = false
	
	if(Input.is_action_just_pressed("down")):
		await get_tree().create_timer(0.1).timeout
		if(right_arm.is_colliding() && animated_sprite_2d.flip_h == false && 
		right_arm.get_collider() is RigidBody2D):
			var Body = right_arm.get_collider()
			Body.startedJump = true
			Body.hitstun = true
			Body.linear_velocity = Vector2i(hitstrengh * hitmultiplyer,-200 * hitmultiplyer)
			hitmultiplyer *= 1.2
			await get_tree().create_timer(0.1).timeout
			Body.startedJump = false
		if(left_arm.is_colliding() && animated_sprite_2d.flip_h == true && 
		left_arm.get_collider() is RigidBody2D):
			var Body = left_arm.get_collider()
			Body.startedJump = true
			Body.hitstun = true
			Body.linear_velocity = Vector2i(-hitstrengh * hitmultiplyer,-200 * hitmultiplyer)
			hitmultiplyer *= 1.2
			await get_tree().create_timer(0.1).timeout
			Body.startedJump = false
			
			
			
	
	
	print(linear_velocity)
	print(position)
	pass
