package ui.windows;

import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import ui.windows.WindowItem;

class WindowGroup extends FlxTypedSpriteGroup<WindowItem>
{
    public var mainWindow:WindowBase;
    
	public function new(windowTitle:String, width:Int, height:Int, ?_x:Int, ?_y:Int)
    {
        super();
        
        mainWindow = new WindowBase(windowTitle, width, height);
        
        mainWindow.x = _x;
        mainWindow.y = _y;

        add(mainWindow);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        for (windowPart in this)
        {
            windowPart.x = mainWindow.x + cast(windowPart, WindowItem).windowPos.x;
            windowPart.y = mainWindow.y + cast(windowPart, WindowItem).windowPos.y;
        }
    }


    public function enableMouseDrag():Void
    {
        this.mainWindow.enableMouseDrag();
    }
}