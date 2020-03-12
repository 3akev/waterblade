extends Node

const PLAYER_SPEED = 130  # in pixels/second

const MAX_ROOM_SIZE = Vector2(25, 20)
const MIN_ROOM_SIZE = Vector2(15, 12)

const ROOM_PADDING = 8
const ROOM_SLOT_SIZE = MAX_ROOM_SIZE + Vector2(ROOM_PADDING, ROOM_PADDING)
const MIN_ROOMS_PER_DUNGEON = 6
const MAX_ROOMS_PER_DUNGEON = 18

const TUNNEL_WIDTH = 4
const MIN_EXTRA_TUNNELS = 2
const MAX_EXTRA_TUNNELS = 5

const MIN_ENEMIES_PER_ROOM = 8
const MAX_ENEMIES_PER_ROOM = 16

const ENEMY_SPEED = 30
