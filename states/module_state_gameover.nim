import csfml

import ../module_utils, ../module_game_data
import ../managers/module_asset_manager
import module_state, module_state_machine

type GameOverState* = ref object of State
    data: GameDate
    background: Sprite

proc newGameOverState*(data: GameDate): GameOverState =
    return GameOverState(data: data, background: newSprite())

method init*(self: GameOverState) =
    self.data.assets.loadTexture("Game Over Background", "resources/sky.png")

    self.background.texture = self.data.assets.getTexture("Game Over Background")


method handleInput*(self: GameOverState) = 
    var event: Event

    while self.data.window.pollEvent event:
        
        if event.kind == EventType.Closed:
            echo "Request Close"
            self.data.window.close()

method update*(self: GameOverState, deltaTime: float) =
    var override = 0
    
method draw*(self: GameOverState, deltaTime: float) =
    self.data.window.clear Black
    self.data.window.draw self.background
    self.data.window.display()