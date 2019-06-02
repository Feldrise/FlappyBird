import csfml
import tables

type AssetManager* = ref object of RootObj
    textures*: Table[string, Texture]
    fonts*: Table[string, Font]

proc newAssetManager*(): AssetManager = 
    return AssetManager(textures: initTable[string, Texture](), fonts: initTable[string, Font]())

method loadTexture*(self: AssetManager, name: string, fileName: string) {.base.} = 
    var texture = newTexture(fileName)
    self.textures[name] = texture

method getTexture*(self: AssetManager, name: string): Texture {.base.} = 
    return self.textures[name]

method loadFont*(self: AssetManager, name: string, fileName: string) {.base.} = 
    var font = newFont(fileName)
    self.fonts[name] = font

method getFont*(self: AssetManager, name: string): Font {.base.} = 
    return self.fonts[name]