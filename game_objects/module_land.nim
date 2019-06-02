import csfml 

import ../managers/module_asset_manager
import ../module_game_data

type Land* = ref object of RootObj
    data: GameData
    landSprites*: seq[Sprite]

proc newLand*(data: GameData): Land =
    var sprite = newSprite(data.assets.getTexture("Land"))
    var sprite2 = newSprite(data.assets.getTexture("Land"))

    sprite.position = vec2(0, data.window.size.y - sprite.localBounds.height.toInt)
    sprite2.position = vec2(sprite2.localBounds.width.toInt, data.window.size.y - sprite2.localBounds.height.toInt)

    return Land(data: data, landSprites: @[sprite, sprite2])

method moveLand*(self: Land, deltaTime: float) {.base.} = 
    for land in self.landSprites:
        var movement = 200.0f * deltaTime

        land.move(vec2(-movement, 0.0f))

        if land.position.x < 0 - land.localBounds.width:
            var position = vec2(self.data.window.size.x.toFloat, land.position.y)

            land.position = position


method drawLand*(self: Land) {.base.} =    
    for land in self.landSprites:
        self.data.window.draw land
