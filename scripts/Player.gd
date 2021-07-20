extends KinematicBody2D

var SPEED = 300
var velocity = Vector2()

func _ready():
    pass

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed("move_right"):
        $Sprite.flip_h = false
        $AnimationPlayer.play("walk_right")
        velocity.x += 1
    if Input.is_action_pressed("move_left"):
        $Sprite.flip_h = true
        $AnimationPlayer.play("walk_right")
        velocity.x -= 1
    
    if !Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
        $Sprite.flip_h = false
        $AnimationPlayer.stop()
        $Sprite.set_frame(0)
        
    velocity = velocity.normalized() * SPEED

func _physics_process(delta):
    get_input()
    var collision_info = move_and_collide(velocity * delta)
    if collision_info:
        velocity = velocity.bounce(collision_info.normal)
