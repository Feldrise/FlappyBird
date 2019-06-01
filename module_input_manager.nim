import csfml

type InputManager* = ref object of RootObj

method isSpriteClicked*(self: InputManager, obj: Sprite, button: MouseButton, window: RenderWindow): bool =
    if mouse_isButtonPressed button:
        var buttonRect = rect(obj.position.x, obj.position.y, obj.globalBounds.width, obj.globalBounds.height)

        if buttonRect.contains mouse_getPosition window:
            return true

    return false

    
method getMousePosition*(self: InputManager, window: RenderWindow): Vector2i =
    return mouse_getPosition window