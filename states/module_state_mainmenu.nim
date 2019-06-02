import csfml

import ../module_utils
import ../managers/module_asset_manager, ../managers/module_input_manager
import module_state, module_state_machine
import ../module_game_data

type MainMenuState* = ref object of State
    data: GameDate
    background: Sprite
    title: Sprite
    playButton: Sprite

proc newMainMenuState*(data: GameDate): MainMenuState = 
    return MainMenuState(data: data, background: newSprite(), title: newSprite(), playButton: newSprite())

method init*(self: MainMenuState) =
    self.data.assets.loadTexture("Main Menu Background", "resources/sky.png")
    self.data.assets.loadTexture("Game Title", "resources/title.png")
    self.data.assets.loadTexture("Play Button", "resources/playButton.png")

    self.background.texture = self.data.assets.getTexture("Main Menu Background")
    self.title.texture = self.data.assets.getTexture("Game Title")
    self.playButton.texture = self.data.assets.getTexture("Play Button")

    self.title.position = vec2((768 / 2) - (self.title.globalBounds.width / 2), self.title.globalBounds.height / 2)
    self.playButton.position = vec2((768 / 2) - (self.playButton.globalBounds.width / 2), (1024 / 2) - (self.playButton.globalBounds.height / 2))

method handleInput*(self: MainMenuState) = 
    var event: Event

    while self.data.window.pollEvent event:
        if event.kind == EventType.Closed:
            self.data.window.close

        if self.data.inputManager.isSpriteClicked(self.playButton, MouseButton.Left, self.data.window):
            echo "Go to the Game"

method update*(self: MainMenuState, deltaTime: float) =
    var ok = 0
    
method draw*(self: MainMenuState, deltaTime: float) =
    self.data.window.clear Black

    self.data.window.draw self.background
    self.data.window.draw self.title
    self.data.window.draw self.playButton

    self.data.window.display()
