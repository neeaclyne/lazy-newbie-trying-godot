extends CharacterBody2D

@export var speed = 80.0

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	var directionH = Input.get_axis("ui_left", "ui_right")
	var directionV = Input.get_axis("ui_up", "ui_down")
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if directionH:
		velocity.x = directionH * speed
	else:
		velocity.x = 0
	if directionV:
		velocity.y = directionV * speed
	else:
		velocity.y = 0
	
	if input_vector == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		move_and_slide()
		$AnimationTree.set("parameters/Idle/blend_position", input_vector)
		$AnimationTree.set("parameters/Walk/blend_position", input_vector)
