import csfml 

import ../managers/module_asset_manager
import ../module_game_data

type Hud* = ref object of RootObj
    data: GameData
    scoreText: Text

proc newHud*(data: GameData): Hud = 
    var scoreText =  newText("0", data.assets.getFont("Flappy Font"), 128)
    scoreText.fillColor = White
    scoreText.origin = vec2(scoreText.globalBounds.width / 2, scoreText.globalBounds.height / 2)
    scoreText.position = vec2(data.window.size.x / 2, data.window.size.y / 5)

    return Hud(data: data, scoreText: scoreText)

method drawHud*(self: Hud) {.base.} = 
    self.data.window.draw self.scoreText

method updateScore*(self: Hud, score: int) {.base.} = 
    self.scoreText.str = $score