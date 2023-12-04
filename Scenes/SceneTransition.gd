extends CanvasLayer

func play_animation():
	$LoadingScreenPlayer.play("dissolve")
	await $LoadingScreenPlayer.animation_finished

func play_animation_backwards():
	$LoadingScreenPlayer.play_backwards("dissolve")
	await $LoadingScreenPlayer.animation_finished
