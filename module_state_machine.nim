import module_state, module_utils

type StateMachine* = ref object of State
    states*: seq[State]
    newState: State

    isRemoving: bool
    isAdding: bool
    isReplacing: bool

method addState*(self: StateMachine, newState: State, isReplacing: bool = true) = 
    self.isAdding = true
    self.isReplacing = isReplacing

    self.newState = newState

method removeState*(self: StateMachine) = 
    self.isRemoving = true

method processStateChanges*(self: StateMachine) = 
    if self.isRemoving and self.states.len > 0:
        discard self.states.pop

        if self.states.len > 0:
            self.states.top.resume

        self.isRemoving = false

    if self.isAdding:
        if self.states.len > 0:
            if self.isReplacing:
                discard self.states.pop
            else:
                self.states.top.pause

        self.states.add(self.newState)
        self.states.top.init
        self.isAdding = false


method getActiveState*(self: StateMachine): State =
    return self.states.top