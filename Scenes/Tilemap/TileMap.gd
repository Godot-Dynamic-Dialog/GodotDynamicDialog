extends TileMap

var apple = preload("res://Scenes/Objects/apple.tscn")
var watermelon = preload("res://Scenes/Objects/watermelon.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn(10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# x = number of object instances to spawn
func spawn(x):
	while (x != 0):
		randomize()
		var fruits = [apple, watermelon]
		var kinds = fruits[randi()% fruits.size()]
		var fruit = kinds.instantiate()
		fruit.position = Vector2(randi_range(100,300), randi_range(-50, -150))
		fruit.z_index = 1
		add_child(fruit)
		x -= 1
