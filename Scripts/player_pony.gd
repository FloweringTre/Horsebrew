extends CharacterBody2D

"""
This implements a very rudimentary state machine. There are better implementations
in the AssetLib if you want to make something more complex. Also it shares code with Enemy.gd
and probably both should extend some parent script
"""

@export var WALK_SPEED: int = 50 # pixels per second
@export var TROT_SPEED: int = 100 # pixels per second
@export var GALLOP_SPEED: int = 150 # pixels per second

var linear_vel = Vector2()
var run_direction = Vector2.DOWN

signal health_changed(current_hp)

@export var facing = "right" # (String, "up", "down", "left", "right")



var anim = ""
var new_anim = ""

enum { STATE_BLOCKED, STATE_IDLE, STATE_WALKING, STATE_TROT, STATE_RUN, STATE_JUMP }

var state = STATE_IDLE

# Move the player to the corresponding spawnpoint, if any and connect to the dialog system



func _physics_process(_delta):
	
	## PROCESS STATES
	match state:
		STATE_BLOCKED:
			new_anim = "idle_" + facing
			pass
		STATE_IDLE:
			if (
					Input.is_action_pressed("down") or
					Input.is_action_pressed("left") or
					Input.is_action_pressed("right") or
					Input.is_action_pressed("up")
				):
					state = STATE_WALKING
			if Input.is_action_just_pressed("sprint"):
				state = STATE_TROT
				run_direction = Vector2(
						- int( Input.is_action_pressed("left") ) + int( Input.is_action_pressed("right") ),
						-int( Input.is_action_pressed("up") ) + int( Input.is_action_pressed("down") )
					).normalized()
				_update_facing()
			new_anim = "idle_" + facing
			pass
		STATE_WALKING:
			if Input.is_action_just_pressed("sprint"):
				state = STATE_TROT
			
			
			
			set_velocity(linear_vel)
			move_and_slide()
			linear_vel = velocity
			
			var target_speed = Vector2()
			
			if Input.is_action_pressed("down"):
				target_speed += Vector2.DOWN
			if Input.is_action_pressed("left"):
				target_speed += Vector2.LEFT
			if Input.is_action_pressed("right"):
				target_speed += Vector2.RIGHT
			if Input.is_action_pressed("up"):
				target_speed += Vector2.UP
			
			target_speed *= WALK_SPEED
			#linear_vel = linear_vel.linear_interpolate(target_speed, 0.9)
			linear_vel = target_speed
			run_direction = linear_vel.normalized()
			
			_update_facing()
			
			if linear_vel.length() > 5:
				new_anim = "walk_" + facing
			else:
				goto_idle()
			pass
		STATE_TROT:
			if Input.is_action_just_pressed("sprint"):
				state = STATE_RUN
			if Input.is_action_just_pressed("slow"):
				state = STATE_WALKING
			
			set_velocity(linear_vel)
			move_and_slide()
			linear_vel = velocity
			
			var target_speed = Vector2()
			
			if Input.is_action_pressed("down"):
				target_speed += Vector2.DOWN
			if Input.is_action_pressed("left"):
				target_speed += Vector2.LEFT
			if Input.is_action_pressed("right"):
				target_speed += Vector2.RIGHT
			if Input.is_action_pressed("up"):
				target_speed += Vector2.UP
			
			target_speed *= TROT_SPEED
			#linear_vel = linear_vel.linear_interpolate(target_speed, 0.9)
			linear_vel = target_speed
			run_direction = linear_vel.normalized()
			
			_update_facing()
			
			if linear_vel.length() > 5:
				new_anim = "trot_" + facing
			else:
				goto_idle()
			pass
		STATE_RUN:
			if Input.is_action_just_pressed("slow"):
				state = STATE_TROT
			
			set_velocity(linear_vel)
			move_and_slide()
			linear_vel = velocity
			
			var target_speed = Vector2()
			
			if Input.is_action_pressed("down"):
				target_speed += Vector2.DOWN
			if Input.is_action_pressed("left"):
				target_speed += Vector2.LEFT
			if Input.is_action_pressed("right"):
				target_speed += Vector2.RIGHT
			if Input.is_action_pressed("up"):
				target_speed += Vector2.UP
			
			target_speed *= GALLOP_SPEED
			#linear_vel = linear_vel.linear_interpolate(target_speed, 0.9)
			linear_vel = target_speed
			run_direction = linear_vel.normalized()
			
			_update_facing()
			
			if linear_vel.length() > 5:
				new_anim = "gallop_" + facing
			else:
				goto_idle()
			pass

	
	## UPDATE ANIMATION
	if new_anim != anim:
		anim = new_anim
		$AnimationPlayer.play(anim)
	pass


func _on_dialog_started():
	state = STATE_BLOCKED

func _on_dialog_ended():
	state = STATE_IDLE


## HELPER FUNCS
func goto_idle():
	linear_vel = Vector2.ZERO
	new_anim = "idle_" + facing
	state = STATE_IDLE


func _update_facing():
	if Input.is_action_pressed("left"):
		facing = "left"
	if Input.is_action_pressed("right"):
		facing = "right"
	if Input.is_action_pressed("up"):
		facing = "up"
	if Input.is_action_pressed("down"):
		facing = "down"




	
