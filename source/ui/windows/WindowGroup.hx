package ui.windows;

import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class WindowGroup extends FlxTypedSpriteGroup<FlxExtendedSprite>
{
    public var mainWindow:WindowBase;

	public function new(windowTitle:String, width:Int, height:Int, x:Int, y:Int)
    {
        super();
        
        mainWindow = new WindowBase(windowTitle, width, height);
        add(mainWindow);
    }
}