extends KinematicBody2D

var SPEED = 1500
var velocity = Vector2()

func _ready():
    velocity = Vector2()
    velocity.y = 1
    velocity = velocity.normalized() * SPEED

func _physics_process(delta):
    var collision_info = move_and_slide(velocity * delta)

func die():
    Global.addToScore()
    yield(get_tree().create_timer(0.4), "timeout")
    $AnimationPlayer.play("die")
    [$"explosion 1", $"explosion 2", $"explosion 3"][randi() % 3].play()
    
    yield(get_tree().create_timer(0.5), "timeout")
    queue_free()
