import csfml
import module_state, module_state_machine, module_utils, module_game, module_asset_manager

type SplashState* = ref object of State
    data: GameDate
    clock: Clock
    backgroundTexture: Texture
    background: Sprite

method init*(self: SplashState) =
    self.data.assets.loadTexture("Splash State Background", "resources/splash_screen.jpg")

    self.background.texture = self.data.assets.getTexture("Splash State Background")


method handleInput*(self: SplashState) = 
    var event: Event

    while self.data.window.pollEvent event:
        if event.kind == EventType.Closed:
            self.data.window.close

method update*(self: SplashState, deltaTime: float) =
            if self.clock.elapsedTime.asSeconds > 5.0f:
                echo "Go To Main Menu"
    
method draw*(self: SplashState, deltaTime: float) =
    self.data.window.clear Black
    self.data.window.draw self.background
    self.data.window.display()
    
    
proc initSplashState*(data: GameDate): SplashState = 
    var state = SplashState(data: data, clock: newClock(), background: newSprite())
    return state