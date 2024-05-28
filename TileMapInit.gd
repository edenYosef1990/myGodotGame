extends TileMap

var noise = FastNoiseLite.new()

func create_noise(x_pos: int, y_pos: int, width: int, height: int):
	for x in range(width):
		for y in range(height):
			var noiseVal = (noise.get_noise_2d(x+x_pos, y+y_pos) + 1) * 2;
			print(noiseVal)
			set_cell(1, Vector2i(x + x_pos, y + y_pos), 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("hello")
	create_noise(0,0,15,15)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
