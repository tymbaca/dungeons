package component

import rl "vendor:raylib"

AnimationMap := make(map[int]Animation, BUFFER_SIZE)
Animation :: struct {
	Sprite: rl.Texture,
}
