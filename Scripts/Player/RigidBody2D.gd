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
@onready var wall_right_cast = $Wall_right_cast
@onready var wall_left_cast = $Wall_left_cast
var exitedwall = true

func _process(delta):
	
	
	if(linear_velocity.x < 0):
		linear_velocity.x += 1200 * delta
		if(linear_velocity.x != 0 && linear_velocity.x > 0):
			linear_velocity.x = 0
	
	if(linear_velocity.x > 0):
		linear_velocity.x += -1200 * delta
		if(linear_velocity.x != 0 && linear_velocity.x < 0):
			linear_velocity.x = 0
	
	
	if(linear_velocity.y < 800):
		linear_velocity.y += 700 * delta
	if(startedJump == false && ground_cast.is_colliding()):
		linear_velocity.y = 0
	
	if(Input.is_action_pressed("d") && hitstun == false && !Input.is_action_pressed("a")):
		if(linear_velocity.x + speed > speed):
			linear_velocity.x = speed
		else:
			linear_velocity.x += speed
	if(Input.is_action_pressed("a") && hitstun == false && !Input.is_action_pressed("d")):
		if(linear_velocity.x + -speed < -speed):
			linear_velocity.x = -speed
		else:
			linear_velocity.x += -speed
	
	var didWallJump = false
	if(Input.is_action_just_pressed("w") && ground_cast.is_colliding() && exitedwall == true || 
	wall_left_cast.is_colliding() && Input.is_action_just_pressed("w") && exitedwall == true ||
	wall_right_cast.is_colliding() && Input.is_action_just_pressed("w") && exitedwall == true):
		linear_velocity = Vector2i(0,0)
		linear_velocity.y -= 500 
		if(wall_right_cast.is_colliding()):
			linear_velocity.y += 180
			linear_velocity.x = -300
			hitstun=true
		if(wall_left_cast.is_colliding()):
			linear_velocity.y += 180
			linear_velocity.x = 300
			hitstun=true
		exitedwall = false
		startedJump = true
		await get_tree().create_timer(0.1).timeout
		startedJump = false
	
	if(exitedwall == false && wall_left_cast.is_colliding() == false && wall_right_cast.is_colliding() == false):
		exitedwall = true
	
	if(Input.is_action_just_pressed("s")):
		await get_tree().create_timer(0.1).timeout
		if(right_arm.is_colliding() && animated_sprite_2d.flip_h == false && 
		right_arm.get_collider() is RigidBody2D):
			get_tree().paused = true
			await get_tree().create_timer(0.03).timeout
			get_tree().paused = false
			var Body = right_arm.get_collider()
			Body.startedJump = true
			Body.hitstun = true
			Body.linear_velocity = Vector2i(hitstrengh * hitmultiplyer,-150 * hitmultiplyer)
			hitmultiplyer *= 1.2
			await get_tree().create_timer(0.1).timeout
			Body.startedJump = false
		if(left_arm.is_colliding() && animated_sprite_2d.flip_h == true && 
		left_arm.get_collider() is RigidBody2D):
			get_tree().paused = true
			await get_tree().create_timer(0.03).timeout
			get_tree().paused = false
			var Body = left_arm.get_collider()
			Body.startedJump = true
			Body.hitstun = true
			Body.linear_velocity = Vector2i(-hitstrengh * hitmultiplyer,-150 * hitmultiplyer)
			hitmultiplyer *= 1.2
			await get_tree().create_timer(0.1).timeout
			Body.startedJump = false
			
			
	if(hitstun == true):
		await get_tree().create_timer(0.3).timeout
		hitstun = false
	
	
	print(linear_velocity)
	#print(position)
	pass
