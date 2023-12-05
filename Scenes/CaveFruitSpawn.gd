extends TileMap

#same code as TileMap.gd, just wanted to change coords for where the fruits spawn
# Called when the node enters the scene tree for the first time.
func _ready():
	var fruits = DialogueDatabase
	print("NUMBER OF FRUITS SPAWNED IN THIS INSTANCE: ", fruits.getNumOfFruits())
	spawn(fruits.getNumOfFruits())
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
# x = number of object instances to spaw
func spawn(x):
	while (x != 0):
		randomize()
		var database = DialogueDatabase
		var fruits = database.fruits
		var kinds = fruits[randi()% fruits.size()]
		var fruit = kinds.instantiate()
		fruit.position = Vector2(randi_range(180,350), randi_range(16, -150))
		fruit.z_index = 1
		add_child(fruit)
		x -= 1
