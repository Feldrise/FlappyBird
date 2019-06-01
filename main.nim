import csfml
import tables
import module_utils, module_game, module_state_machine, module_state_splash, module_asset_manager

proc initGame*(width: cint, height: cint, title: string): Game =
  var deltaTime = 10.0f / 120.0f
  var window = newRenderWindow(videoMode(width, height), title)

  var data = GameDate(window: window, machine: StateMachine(states: @[]), assets: AssetManager(textures: initTable[string, Texture]()))

  data.machine.addState(initSplashState(data))

  return Game(deltaTime: deltaTime, data: data, clock: newClock())

var 
  game = initGame(768, 1024, "Essay")

game.run