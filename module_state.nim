type State* = ref object of RootObj

method init*(self: State) {.base.} = 
    quit "Init: to override!"

method handleInput*(self: State) {.base.}  = 
    quit "Handle: to override!"

method update*(self: State, deltaTime: float) {.base.}  = 
    quit "Update: to override!"
    
method draw*(self: State, deltaTime: float) {.base.}  =   
    quit "Draw: to override!"
    
method pause*(self: State) {.base.}  =
    quit "Pause: to override!"

method resume*(self: State) {.base.}  =
    quit "Resume: to override!"