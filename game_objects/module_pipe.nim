import csfml 
import sequtils
import random

import ../managers/module_asset_manager
import ../module_game_data

randomize()

type Pipe* = ref object of RootObj
    data*: GameData 
    pipeSprites*: seq[Sprite]
    scoringSprites*: seq[Sprite]
    landHeight: int
    pipeSpawnYOffset: int

proc newPipe*(data: GameData): Pipe = 
    return Pipe(data: data, pipeSprites: @[], scoringSprites: @[], landHeight: data.assets.getTexture("Land").size.y, pipeSpawnYOffset: 0)

method spawnBottomPipe*(self: Pipe) {.base.} = 
    var sprite = newSprite(self.data.assets.getTexture("Pipe Up"))

    sprite.position = vec2(self.data.window.size.x, self.data.window.size.y - sprite.globalBounds.height.toInt() - self.pipeSpawnYOffset)

    self.pipeSprites.add(sprite)


method spawnTopPipe*(self: Pipe) {.base.} =  
    var sprite = newSprite(self.data.assets.getTexture("Pipe Down"))

    sprite.position = vec2(self.data.window.size.x, -self.pipeSpawnYOffset)

    self.pipeSprites.add(sprite)

method spawnScoringPipe*(self: Pipe) {.base.} =
    var sprite = newSprite(self.data.assets.getTexture("Scoring Pipe"))

    sprite.position = vec2(self.data.window.size.x, 0)

    self.scoringSprites.add(sprite)

method spawnInvisiblePipe*(self: Pipe) {.base.} =
    var sprite = newSprite()

    sprite.position = vec2(self.data.window.size.x, self.data.window.size.y - sprite.globalBounds.height.toInt())
    sprite.color = color(0, 0, 0, 0)

    self.pipeSprites.add(sprite)

method movePipes*(self: Pipe, deltaTime: float) {.base.} = 
    for pipe in self.pipeSprites:      
        var mouvement = 200.0f * deltaTime

        pipe.move(vec2(-mouvement, 0))

    if self.pipeSprites.len > 0 and self.pipeSprites[0].position.x < 0 - self.pipeSprites[0].globalBounds.width:
        self.pipeSprites.delete(0)

    for sprite in self.scoringSprites:      
        var mouvement = 200.0f * deltaTime

        sprite.move(vec2(-mouvement, 0))

    if self.scoringSprites.len > 0 and self.scoringSprites[0].position.x < 0 - self.scoringSprites[0].globalBounds.width:
        self.scoringSprites.delete(0)
    
method drawPipes*(self: Pipe) {.base.} = 
    for pipe in self.pipeSprites:
        self.data.window.draw pipe

method randomizePipeOffset*(self: Pipe) {.base.} = 
    self.pipeSpawnYOffset = random(self.landHeight)