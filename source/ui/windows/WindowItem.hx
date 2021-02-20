package ui.windows;

import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import openfl.display.BitmapData;

/**
 * ...
 * @author Hunter
 */
class WindowItem extends FlxExtendedSprite
{
	public var windowPos:FlxPoint;

	public function new(windowRelativeX:Int, windowRelativeY:Int, ?bitmapData:BitmapData)
	{
		super(0, 0, bitmapData);
		windowPos = FlxPoint.get(windowRelativeX, windowRelativeY);
	}
}
