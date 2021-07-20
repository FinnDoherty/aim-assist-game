extends Node2D

var open = false;
var buttons = []

var currentTurret = 0
var currentEnemyTile = 0
var selectedTile = null
var locked = true

signal turret_fire

func _ready():
    buttons = [
        $VBoxContainer/GridContainer/TextureButton1,
        $VBoxContainer/GridContainer/TextureButton2,
        $VBoxContainer/GridContainer/TextureButton3,
        $VBoxContainer/GridContainer/TextureButton4,
        $VBoxContainer/GridContainer/TextureButton5,
        $VBoxContainer/GridContainer/TextureButton6,
        $VBoxContainer/GridContainer/TextureButton7,
        $VBoxContainer/GridContainer/TextureButton8,
        $VBoxContainer/GridContainer/TextureButton9
    ] 
    
    for i in buttons.size():
        buttons[i].connect("pressed", self, "on_button_pressed", [i])
    
func setUpCards():
    locked = false
    selectedTile = null
    currentEnemyTile = randi() % 9
    
    for tile in buttons.size():
        buttons[tile].get_child(0).frame = 0
        
    if Global.isMobInLane(currentTurret):
        buttons[currentEnemyTile].get_child(0).frame = 1
    
func on_turret_entered(turretNumber):
    currentTurret = turretNumber
       
    setUpCards()
    if !open:
        $TimerOpen.start()

func on_turret_exited():
    if open:
        $AnimationPlayer.play_backwards("open")
        $"door close".play()
    open = false

func _on_Timer_timeout():
    if !Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
        $AnimationPlayer.play("open")
        $"door open".play()
        open = true
    else:
        $TimerOpen.start()
        
func hit():
    emit_signal("turret_fire", currentTurret, true)
    
    on_turret_exited()
    yield(get_tree().create_timer(0.4), "timeout")
    
    on_turret_entered(currentTurret)
    
func miss():
    emit_signal("turret_fire", currentTurret, false)
    
func _on_red_button_pressed():
    $"VBoxContainer/red button/AnimationPlayer".play("push_button")
    [$"fire sound 1", $"fire sound 2", $"fire sound 3"][randi() % 3].play()
    if !locked:
        if selectedTile == currentEnemyTile:
            locked = true
            hit()
        else:
            miss()
        
func toggleFrame(selectedTile):
    var toggle = [3, 2, 1, 0]
    
    selectedTile.get_child(0).frame = toggle[selectedTile.get_child(0).frame]
    
func on_button_pressed(i):
    [$"button pushed 1", $"button pushed 2", $"button pushed 3"][randi() % 3].play()
    
    if selectedTile != null:
        toggleFrame(buttons[selectedTile])
    selectedTile = i
    toggleFrame(buttons[selectedTile])
