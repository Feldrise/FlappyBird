import csfml

import ../module_utils, ../module_game_data
import ../managers/module_asset_manager
import module_state, module_state_machine

type GameState* = ref object of State
    data: GameDate
    background: Sprite

proc newGameState*(data: GameDate): GameState =
    return GameState(data: data, background: newSprite())

method init*(self: GameState) =
    self.data.assets.loadTexture("Game Background", "resources/sky.png")

    self.background.texture = self.data.assets.getTexture("Game Background")


method handleInput*(self: GameState) = 
    var event: Event

    while self.data.window.pollEvent event:
        
        if event.kind == EventType.Closed:
            echo "Request Close"
            self.data.window.close()

method update*(self: GameState, deltaTime: float) =
    var override = 0
    
method draw*(self: GameState, deltaTime: float) =
    self.data.window.clear Black
    self.data.window.draw self.background
    self.data.window.display()