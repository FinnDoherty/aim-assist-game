extends ColorRect

onready var anim_player = $AnimationPlayer

func _ready():
    anim_player.play_backwards("Fade")

func transition_to(next_scene):
    anim_player.play("Fade")

    yield(get_tree().create_timer(0.5), "timeout")
    get_tree().change_scene(next_scene)
