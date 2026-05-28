extends Node

var music_enabled = true
var sfx_enabled = true

var upgrade_sound = preload("res://audio/sfx/collect_coin_3.wav")
var unlock_sound = preload("res://audio/sfx/collect_coin_7.wav")
var click_sound = preload("res://audio/sfx/click.mp3")
var hover_sound = preload("res://audio/sfx/hover.mp3")
var earn_sound = preload("res://audio/sfx/earn-money.mp3")
var bgm_player: AudioStreamPlayer

var bgm_music = preload("res://audio/music/Pastel Dreaming.mp3")

func _ready():
	bgm_player = AudioStreamPlayer.new()
	bgm_player.bus = "Music"
	bgm_player.stream = bgm_music
	bgm_player.autoplay = false
	add_child(bgm_player)
	
	bgm_player.finished.connect(_on_music_finished)

	play_music()

func play_music():
	if !music_enabled:
		return
	bgm_player.play()

func _on_music_finished():
	bgm_player.play()

func toggle_music(value):
	music_enabled = value

	AudioServer.set_bus_mute(
		AudioServer.get_bus_index("Music"),
		!value
	)


func toggle_sfx(value):
	sfx_enabled = value

	AudioServer.set_bus_mute(
		AudioServer.get_bus_index("SFX"),
		!value
	)


func play_sfx(sound):
	if !sfx_enabled:
		return

	var player = AudioStreamPlayer.new()

	player.stream = sound
	player.bus = "SFX"

	add_child(player)

	player.play()

	player.finished.connect(player.queue_free)
