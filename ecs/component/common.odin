package component

import "core:fmt"
import rl "vendor:raylib"

Player :: struct {}

ShapeMap := make(map[int]Shape, BUFFER_SIZE)
Shape :: union #no_nil {
	Rectangle,
	Circle,
}
Rectangle :: struct {
	width, height: f32,
}
Circle :: struct {
	radius: f32,
}

DisplayMap := make(map[int]Display, BUFFER_SIZE)
Display :: distinct bool

HealthMap := make(map[int]Health, BUFFER_SIZE)
Health :: distinct f32

VelocityMap := make(map[int]Velocity, BUFFER_SIZE)
Velocity :: distinct rl.Vector2

PositionMap := make(map[int]Position, BUFFER_SIZE)
Position :: distinct rl.Vector2
