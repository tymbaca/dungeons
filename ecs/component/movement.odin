package component

MovementMap := make(map[int]Movement, BUFFER_SIZE)
Movement :: struct {
	speed: f32,
}

MovementStateMap := make(map[int]MovementState, BUFFER_SIZE)
MovementState :: enum {
	IDLE,
	UP,
	DOWN,
	LEFT,
	RIGHT,
}
