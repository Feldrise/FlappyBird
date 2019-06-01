import csfml

import module_state, module_state_machine, module_asset_manager, module_input_manager

type GameDate* = ref object of RootObj
    machine*: StateMachine
    window*: RenderWindow
    assets*: AssetManager
    inputManager: InputManager

type Game* = ref object of RootObj
    deltaTime*: float
    clock*: Clock
    data*: GameDate

method run*(self: Game) =  
    var newTime, frameTime, interpolation: float 
    var currentTime = self.clock.elapsedTime.asSeconds
    var accumulator = 0.0f

    while self.data.window.open:
        self.data.machine.processStateChanges

        newTime = self.clock.elapsedTime.asSeconds
        frameTime = newTime - currentTime

        if frameTime > 0.25f:
            frameTime = 0.25f

        currentTime = newTime
        accumulator = accumulator + frameTime

        while accumulator >= self.deltaTime:
            self.data.machine.getActiveState.handleInput()
            self.data.machine.getActiveState.update(self.deltaTime)

        interpolation = accumulator / self.deltaTime

        self.data.machine.getActiveState.draw(interpolation)