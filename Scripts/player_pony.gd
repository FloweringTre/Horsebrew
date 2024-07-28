extends CharacterBody2D

class_name Player_Pony

@export var WALK_SPEED: int = 50 # pixels per second
@export var TROT_SPEED: int = 100 # pixels per second
@export var GALLOP_SPEED: int = 150 # pixels per second

var linear_vel = Vector2()
var run_direction = Vector2.DOWN

@export var facing = "right" # (String, "up", "down", "left", "right")
@onready var color = self.modulate.a
@export var level = 0

var anim = ""
var new_anim = ""

enum { STATE_BLOCKED, STATE_IDLE, STATE_WALKING, STATE_TROT, STATE_RUN, STATE_JUMP, STATE_REAR }

var state = STATE_IDLE

# Move the player to the corresponding spawnpoint, if any and connect to the dialog system

func _ready():
	Dialogic.signal_event.connect(DialogicSignalEvent)
	var spawnpoints = get_tree().get_nodes_in_group("spawnpoints")
	for spawnpoint in spawnpoints:
		if spawnpoint.name == Globals.spawnpoint:
			global_position = spawnpoint.global_position
			break
	
	#connects to dialogic signals

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
		STATE_JUMP:
			set_velocity(linear_vel)
			move_and_slide()
			linear_vel = velocity
			var target_speed = Vector2()
			target_speed = run_direction
			target_speed *= GALLOP_SPEED - 25
			#linear_vel = linear_vel.linear_interpolate(target_speed, 0.9)
			linear_vel = target_speed
			if linear_vel.length() > 5:
				new_anim = "jump_" + facing
			else:
				goto_rear()
			pass
		STATE_REAR:
			new_anim = "rear_" + facing
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
			if Input.is_action_just_pressed("sprint") && level >= 2:
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
			if Input.is_action_just_pressed("jump") && level >= 3:
				state = STATE_JUMP
			
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

func DialogicSignalEvent(argument:String):
	if argument == "DialogueStart":
		state = STATE_BLOCKED
		print("PAUSETHEPONY")
	if argument == "DialogueEnd":
		state = STATE_IDLE
		print("#LETSGOFASSTTTTT")
	if argument == "LevelUp":
		level_up()
		print(level)
	pass

func level_up():
	level += 1
	

## HELPER FUNCS
func goto_idle():
	linear_vel = Vector2.ZERO
	new_anim = "idle_" + facing
	state = STATE_IDLE

func goto_rear():
	linear_vel = Vector2.ZERO
	new_anim = "rear_" + facing
	state = STATE_REAR

func goto_run():
	linear_vel = velocity
	new_anim = "gallop_" + facing
	state = STATE_RUN

func _update_facing():
	if Input.is_action_pressed("left"):
		facing = "left"
	if Input.is_action_pressed("right"):
		facing = "right"
	if Input.is_action_pressed("up"):
		facing = "up"
	if Input.is_action_pressed("down"):
		facing = "down"
		
	if Input.is_action_pressed("left") && Input.is_action_pressed("up"):
		facing = "left"
	if Input.is_action_pressed("right") && Input.is_action_pressed("up"):
		facing = "right"
	if Input.is_action_pressed("left") && Input.is_action_pressed("down"):
		facing = "left"
	if Input.is_action_pressed("right") && Input.is_action_pressed("down"):
		facing = "right"

func _on_area_2d_body_entered(body):
	if state == STATE_JUMP:
		goto_rear()
	else:
		pass


func _on_jump_collision_body_entered(body):
	if state == STATE_JUMP:
		goto_rear()
	else:
		pass
