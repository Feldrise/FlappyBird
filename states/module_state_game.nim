import csfml

import ../module_utils, ../module_game_data
import ../managers/module_asset_manager, ../managers/module_input_manager
import ../game_objects/module_pipe
import module_state, module_state_machine

type GameState* = ref object of State
    data: GameData
    background: Sprite
    pipe: Pipe

proc newGameState*(data: GameData): GameState =
    return GameState(data: data, background: newSprite(), pipe: newPipe(data))

method init*(self: GameState) =
    self.data.assets.loadTexture("Game Background", "resources/sky.png")
    self.data.assets.loadTexture("Pipe Up", "resources/PipeUp.png")
    self.data.assets.loadTexture("Pipe Down", "resources/PipeDown.png")

    self.background.texture = self.data.assets.getTexture("Game Background")


method handleInput*(self: GameState) = 
    var event: Event

    while self.data.window.pollEvent event:
        
        if event.kind == EventType.Closed:
            echo "Request Close"
            self.data.window.close()

        if self.data.inputManager.isSpriteClicked(self.background, MouseButton.Left, self.data.window):
            self.pipe.spawnInvisiblePipe()
            self.pipe.spawnBottomPipe()
            self.pipe.spawnTopPipe()


method update*(self: GameState, deltaTime: float) =
    self.pipe.movePipes(deltaTime)
    
method draw*(self: GameState, deltaTime: float) =
    self.data.window.clear Black
    self.data.window.draw self.background
    self.pipe.drawPipes
    self.data.window.display()