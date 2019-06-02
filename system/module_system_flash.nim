import csfml

import ../module_game_data

type FlashSystem* = ref object of RootObj
    data: GameData
    shape: RectangleShape
    flashOn: bool

proc newFlash*(data: GameData): FlashSystem =
    var shape = newRectangleShape(data.window.size)
    shape.fillColor = color(255, 255, 255, 0)

    return FlashSystem(data: data, shape: shape, flashOn: true)

method show*(self: FlashSystem, deltaTime: float) {.base.} =
    if self.flashOn:
        var alpha = cast[int](self.shape.fillColor.a) + toInt(1500 * deltaTime)
        if alpha >= 255:
            alpha = 255
            self.flashOn = false

        self.shape.fillColor = color(255, 255, 255, alpha)
    else:
        var alpha = cast[int](self.shape.fillColor.a) - toInt(1500 * deltaTime)

        if alpha <= 0:
            alpha = 0
            self.flashOn = false

        self.shape.fillColor = color(255, 255, 255, alpha)
    
method drawFlash*(self: FlashSystem) {.base.} =
    self.data.window.draw self.shape