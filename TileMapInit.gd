@tool
extends TileMap

var noise = FastNoiseLite.new()

func foo(val: float):
	val = val * 13
	val = min(val,1)
	val = max(val,-1)
	return val

func create_noise(x_pos: int, y_pos: int, width: int, height: int):
	noise.seed = 10
	#noise.cellular_jitter =
	#noise.cellular_distance_function = FastNoiseLite.DISTANCE_EUCLIDEAN
	#noise.cellular_return_type =FastNoiseLite.RETURN_DISTANCE 
	#noise.domain_warp_amplitude = 4.200
	#noise.domain_warp_frequency = 0.614
	#noise.fractal_gain = 0.150
	#noise.fractal_ping_pong_strength = 0.83
	#noise.fractal_lacunarity = 4.050
	#noise.noise_type = FastNoiseLite.TYPE_PERLIN
	#noise.cellular_jitter = 0.881
	for x in range(width):
		for y in range(height):
			var val = noise.get_noise_2d((x+x_pos) * 1.5, (y+y_pos) * 1.5); 
			var noiseVal = floori((foo(val) + 1) * 1.5);
			print(noiseVal)
			set_cell(0, Vector2i(x + x_pos, y + y_pos), 1, Vector2i(4 * noiseVal ,0))

# Called when the node enters the scene tree for the first time.
func _ready():
	print("hello")
	create_noise(0,0,100,100)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
