import csfml

import ../managers/module_asset_manager
import ../module_game_data

type BirdState* = enum
    still, flying, falling

type Bird* = ref object of RootObj
    data: GameData
    birdSprite: Sprite
    animationFrames: seq[Texture]
    animationIterator: int
    clock: Clock
    movementClock: Clock
    birdState: BirdState
    rotation: float

proc newBird*(data: GameData): Bird =
    var birdSprite = newSprite(data.assets.getTexture("Bird Frame 1"))
    birdSprite.position = vec2((data.window.size.x / 4) - (birdSprite.globalBounds.width / 2), (data.window.size.y / 2) - (birdSprite.globalBounds.height / 2))

    var origin = vec2(birdSprite.globalBounds.width / 2, birdSprite.globalBounds.height / 2)
    birdSprite.origin = origin

    return Bird(data: data, 
                birdSprite: birdSprite,
                animationFrames: @[data.assets.getTexture("Bird Frame 1"), data.assets.getTexture("Bird Frame 2"), data.assets.getTexture("Bird Frame 3"), data.assets.getTexture("Bird Frame 4")],
                animationIterator: 0,
                clock: newClock(),
                movementClock: newClock(),
                birdState: still,
                rotation: 0.0f)

method drawBird*(self: Bird) {.base.} =
    self.data.window.draw self.birdSprite

method update*(self: Bird, deltaTime: float) {.base.} = 
    if self.birdState == falling:
        self.birdSprite.move(vec2(0, 350.0f * deltaTime))
        self.rotation = self.rotation + 100.0f * deltaTime

        if self.rotation > 25.0f:
            self.rotation = 25.0f

        self.birdSprite.rotation = self.rotation
    elif self.birdState == flying:
        self.birdSprite.move(vec2(0, -350f * deltaTime))
        self.rotation = self.rotation - 100.0f * deltaTime

        if self.rotation < -25.0f:
            self.rotation = -25.0f

        self.birdSprite.rotation = self.rotation

    if self.movementClock.elapsedTime.asSeconds > 0.25f:
        discard self.movementClock.restart()

        self.birdState = falling

method tap*(self: Bird) {.base.} = 
    discard self.movementClock.restart()

    self.birdState = flying

method animate*(self: Bird, deltaTime: float) {.base.} =
    if self.clock.elapsedTime.asSeconds > 0.3f / self.animationFrames.len.toFloat:
        if self.animationIterator < self.animationFrames.len - 1:
            self.animationIterator = self.animationIterator + 1
        else:
            self.animationIterator = 0

        self.birdSprite.texture = self.animationFrames[self.animationIterator]

        discard self.clock.restart()
