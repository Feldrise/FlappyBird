import csfml 
import module_asset_manager, module_input_manager
import module_state_machine

type GameDate* = ref object of RootObj
    machine*: StateMachine
    window*: RenderWindow
    assets*: AssetManager
    inputManager*: InputManager

proc newGameData*(width: cint, height: cint, title: string): GameDate = 
    return GameDate(machine: newStateMachine(), window: newRenderWindow(videoMode(width, height), title), assets: newAssetManager(), inputManager: InputManager())