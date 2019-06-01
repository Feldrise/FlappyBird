import csfml
import tables

type AssetManager* = ref object of RootObj
    textures: Table[string, Texture]
    fonts: Table[string, Font]

method loadTexture*(self: AssetManager, name: string, fileName: string) = 
    var texture = newTexture(fileName)
    self.textures[name] = texture

method getTexture*(self: AssetManager, name: string): Texture = 
    return self.textures[name]

method loadFont*(self: AssetManager, name: string, fileName: string) = 
    var font = newFont(fileName)
    self.fonts[name] = font

method getFont*(self: AssetManager, name: string): Font = 
    return self.fonts[name]