import ../module_utils
import ../states/module_state

type StateMachine* = ref object of State
    states*: seq[State]
    newState: State

    isRemoving: bool
    isAdding: bool
    isReplacing: bool

proc newStateMachine*(): StateMachine =
    return StateMachine(states: newSeq[State](), newState: State(), isRemoving: false, isAdding: false, isReplacing: false)

method addState*(self: StateMachine, newState: State, isReplacing: bool = true) {.base.} = 
    self.isAdding = true
    self.isReplacing = isReplacing

    self.newState = newState

method removeState*(self: StateMachine) {.base.} = 
    self.isRemoving = true

method processStateChanges*(self: StateMachine) {.base.} = 
    # echo "Process Change"
    if self.isRemoving and self.states.len > 0:
        discard self.states.pop

        if self.states.len > 0:
            self.states.top.resume

        self.isRemoving = false

    if self.isAdding:
        # echo "Adding"
        if self.states.len > 0:
            if self.isReplacing:
                discard self.states.pop
            else:
                self.states.top.pause

        self.states.add(self.newState)
        self.states.top.init
        self.isAdding = false


method getActiveState*(self: StateMachine): State {.base.} =
    return self.states.top