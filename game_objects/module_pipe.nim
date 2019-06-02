import csfml 

import ../managers/module_asset_manager
import ../module_game_data

type Pipe* = ref object of RootObj
    data*: GameData 
    pipeSprites*: seq[Sprite]

proc newPipe*(data: GameData): Pipe = 
    return Pipe(data: data, pipeSprites: @[])

method spawnBottomPipe*(self: Pipe) {.base.} = 
    var sprite = newSprite(self.data.assets.getTexture("Pipe Up"))

    sprite.position = vec2(self.data.window.size.x, self.data.window.size.y - sprite.globalBounds.height.toInt())

    self.pipeSprites.add(sprite)


method spawnTopPipe*(self: Pipe) {.base.} =  
    var sprite = newSprite(self.data.assets.getTexture("Pipe Down"))

    sprite.position = vec2(self.data.window.size.x, 0)

    self.pipeSprites.add(sprite)

method spawnInvisiblePipe*(self: Pipe) {.base.} =
    var sprite = newSprite()

    sprite.position = vec2(0, 0)
    sprite.color = color(0, 0, 0, 0)

    self.pipeSprites.add(sprite)

method movePipes*(self: Pipe, deltaTime: float) {.base.} = 
    for pipe in self.pipeSprites:
        var mouvement = 200.0f * deltaTime

        pipe.move(vec2(-mouvement, 0))
    
method drawPipes*(self: Pipe) {.base.} = 
    for pipe in self.pipeSprites:
        self.data.window.draw pipe