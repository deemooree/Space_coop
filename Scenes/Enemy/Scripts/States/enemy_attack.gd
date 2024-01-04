extends State
class_name enemy_attack_state

var has_dealt_damage #Only damage once during each attack

signal DealDamage
@export var damage = 25

@onready var enemy = $"../.."
@onready var hit_particles = $"../../AnimatedSprite2D/HitParticles"
@export var animator : AnimationPlayer

func Enter():
	has_dealt_damage = false

	animator.play("Attack")
	await animator.animation_finished
	enemy.finished_attacking()
	
func Exit():
	has_dealt_damage = false
	
#During attack animation, Hitbox is activated and tries to find the player
func _on_hit_box_body_entered(body):
	if body.is_in_group("Player") and has_dealt_damage == false:
		var player = body as PlayerMain
		deal_damage_to_player(player)

#Connect and deal damage to the player
func deal_damage_to_player(player):
	hit_particles.emitting = true
	
	player.ConnectForDamage(self)
	emit_signal("DealDamage", damage)
	has_dealt_damage = true
	
func play_hitground_sound():
	AudioManager.play_sound(AudioManager.ENEMY_HIT, 0, -10)
	



