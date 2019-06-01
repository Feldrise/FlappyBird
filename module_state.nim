type State* = ref object of RootObj

method init*(self: State) {.base.} = 
    quit "to override!"

method handleInput*(self: State) {.base.}  = 
    quit "to override!"

method update*(self: State, deltaTime: float) {.base.}  = 
    quit "to override!"
    
method draw*(self: State, deltaTime: float) {.base.}  =   
    quit "to override!"
    
method pause*(self: State) {.base.}  =
    quit "to override!"

method resume*(self: State) {.base.}  =
    quit "to override!"