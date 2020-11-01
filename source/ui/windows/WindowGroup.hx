package ui.windows;

import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxRect;
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

		mainWindow = new WindowBase(windowTitle, width, height, drawBorders, baseWindowBitmapData);
		mainWindow.enableMouseDrag();
		add(mainWindow);
	}

	/*
		override public function add(windowPart:WindowItem):WindowItem
		{
			preAdd(windowPart);
			windowPart.x = mainWindow.x + windowPart.windowPos.x;
			windowPart.y = mainWindow.y + windowPart.windowPos.y;
			windowPart.scrollFactor.set(0, 0);
			return group.add(windowPart);
		}
	 */
	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		for (windowPart in this)
		{
			if (windowPart != mainWindow)
			{
				windowPart.x = mainWindow.x + windowPart.windowPos.x;
				windowPart.y = mainWindow.y + windowPart.windowPos.y;
			}
		}
	}
}
