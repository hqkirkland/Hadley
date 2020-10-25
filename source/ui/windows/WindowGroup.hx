package ui.windows;

import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import openfl.display.BitmapData;
import ui.windows.WindowItem;

class WindowGroup extends FlxTypedSpriteGroup<WindowItem>
{
	public var mainWindow:WindowBase;

	public function new(windowTitle:String, width:Int, height:Int, x:Int, y:Int, ?drawBorders:Bool = true, ?baseWindowBitmapData:BitmapData)
	{
		super();
		this.width = width;
		this.height = height;
		this.x = x;
		this.y = y;

		mainWindow = new WindowBase(windowTitle, width, height, drawBorders, baseWindowBitmapData);
		mainWindow.enableMouseDrag();
		add(mainWindow);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		for (windowPart in this)
		{
			windowPart.x = mainWindow.x + windowPart.windowPos.x;
			windowPart.y = mainWindow.y + windowPart.windowPos.y;
		}
	}
}
