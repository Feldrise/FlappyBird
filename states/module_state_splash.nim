import csfml

import ../module_utils, ../module_game_data
import ../managers/module_asset_manager
import module_state, module_state_machine
import module_state_mainmenu

type SplashState* = ref object of State
    data: GameDate
    clock: Clock
    background: Sprite

proc newSplashState*(data: GameDate): SplashState =
    return SplashState(data: data, clock: newClock(), background: newSprite())

method init*(self: SplashState) =
    self.data.assets.loadTexture("Splash State Background", "resources/splash_screen.jpg")

    self.background.texture = self.data.assets.getTexture("Splash State Background")


method handleInput*(self: SplashState) = 
    var event: Event

    while self.data.window.pollEvent event:
        
        if event.kind == EventType.Closed:
            echo "Request Close"
            self.data.window.close()

method update*(self: SplashState, deltaTime: float) =
            if self.clock.elapsedTime.asSeconds > 3.0f:
                self.data.machine.addState(newMainMenuState(self.data), true)
                self.data.machine.processStateChanges()
    
method draw*(self: SplashState, deltaTime: float) =
    self.data.window.clear Black
    self.data.window.draw self.background
    self.data.window.display()