extends Spatial

const KILL_TIMER = 4

var bullet_speed = 70
var bullet_damage = 15
var timer = 0
var hit_something = false

func _ready():
	$Area.connect("body_entered", self, "collided")

func _physics_process(delta):
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * bullet_speed * delta)
	timer += delta
	if timer >= KILL_TIMER:
		queue_free()

func collided(body):
	if hit_something == false:
		if body.has_method("bullet_hit"):
			body.bullet_hit(bullet_damage , global_transform)
	hit_something = true
	queue_free()
