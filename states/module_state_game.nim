import csfml

import ../module_utils, ../module_game_data
import ../managers/module_asset_manager, ../managers/module_input_manager
import ../game_objects/module_pipe, ../game_objects/module_land, ../game_objects/module_bird
import module_state, module_state_machine
import ../system/module_system_collision, ../system/module_system_flash

type GameStates = enum
    eReady, ePlaying, eGameOver

type GameState* = ref object of State
    data: GameData
    clock: Clock
    background: Sprite
    pipe: Pipe
    gameState: GameStates
    land: Land
    bird: Bird
    collision: CollisionSystem
    flash: FlashSystem

proc newGameState*(data: GameData): GameState =
    return GameState(data: data, clock: newClock(), background: newSprite())

method init*(self: GameState) =
    self.data.assets.loadTexture("Game Background", "resources/sky.png")
    self.data.assets.loadTexture("Pipe Up", "resources/PipeUp.png")
    self.data.assets.loadTexture("Pipe Down", "resources/PipeDown.png")
    self.data.assets.loadTexture("Land", "resources/Land.png")

    self.data.assets.loadTexture("Bird Frame 1", "resources/bird-01.png")
    self.data.assets.loadTexture("Bird Frame 2", "resources/bird-02.png")
    self.data.assets.loadTexture("Bird Frame 3", "resources/bird-03.png")
    self.data.assets.loadTexture("Bird Frame 4", "resources/bird-04.png")

    self.background.texture = self.data.assets.getTexture("Game Background")

    self.pipe = newPipe(self.data)
    self.land = newLand(self.data)
    self.bird = newBird(self.data)

    self.flash = newFlash(self.data)

    self.gameState = eReady

method handleInput*(self: GameState) = 
    var event: Event

    while self.data.window.pollEvent event:
        
        if event.kind == EventType.Closed:
            echo "Request Close"
            self.data.window.close()

        if self.data.inputManager.isSpriteClicked(self.background, MouseButton.Left, self.data.window):
            if self.gameState != eGameOver:
                self.gameState = ePlaying
                self.bird.tap()


method update*(self: GameState, deltaTime: float) =
    if self.gameState != eGameOver:
        self.land.moveLand(deltaTime)
        self.bird.animate(deltaTime)

    if self.gameState == ePlaying:
        self.pipe.movePipes(deltaTime)

        if self.clock.elapsedTime.asSeconds > 2.0f:
            self.pipe.randomizePipeOffset()
            self.pipe.spawnInvisiblePipe()
            self.pipe.spawnBottomPipe()
            self.pipe.spawnTopPipe()

            discard self.clock.restart()
        
        self.bird.update(deltaTime)

        for land in self.land.landSprites:
            if self.collision.checkCollisionSprite(self.bird.birdSprite, land):
                self.gameState = eGameOver

        for pipe in self.pipe.pipeSprites:
            if self.collision.checkCollisionSprite(self.bird.birdSprite, pipe):
                self.gameState = eGameOver

    if self.gameState == eGameOver:
        self.flash.show(deltaTime)
    
method draw*(self: GameState, deltaTime: float) =
    self.data.window.clear Black
  
    self.data.window.draw self.background
    self.pipe.drawPipes()
    self.land.drawLand()
    self.bird.drawBird()

    self.flash.drawFlash()

    self.data.window.display()