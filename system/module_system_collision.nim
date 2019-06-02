import csfml 

type CollisionSystem* = ref object of RootObj

method checkCollisionSprite*(self: CollisionSystem, sprite1: Sprite, sprite2: Sprite): bool {.base.} =
    var rect1 = sprite1.globalBounds
    var rect2 = sprite2.globalBounds
    var intersection: FloatRect
    
    if rect1.intersects(rect2, intersection):
        return true
    else:
        return false