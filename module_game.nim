import csfml

import managers/module_asset_manager, managers/module_input_manager
import states/module_state, states/module_state_machine
import states/module_state_splash
import module_game_data

type Game* = ref object of RootObj
    deltaTime*: float
    clock*: Clock
    data*: GameData

proc newGame*(width: cint, height: cint, title: string): Game = 
    return Game(deltaTime: 10.0f / 1200.0f, clock: newClock(), data: newGameData(width, height, title))

method init*(self: Game) {.base.} =
  self.data.machine.addState(newSplashState(self.data))

method run*(self: Game) {.base.} =  
    var newTime, frameTime, interpolation: float 
    var currentTime = self.clock.elapsedTime.asSeconds
    var accumulator = 0.0f

    while self.data.window.open:
        # echo "Update()"
        self.data.machine.processStateChanges

        newTime = self.clock.elapsedTime.asSeconds
        frameTime = newTime - currentTime

        if frameTime > 0.025f:
            frameTime = 0.025f

        currentTime = newTime
        accumulator = accumulator + frameTime

        while accumulator >= self.deltaTime:
            self.data.machine.getActiveState.handleInput()
            self.data.machine.getActiveState.update(self.deltaTime)

            accumulator = accumulator - self.deltaTime

        interpolation = accumulator / self.deltaTime

        self.data.machine.getActiveState.draw(interpolation)

    echo "Close()"