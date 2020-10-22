package ui.windows;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import openfl.display.BitmapData;

import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.addons.display.FlxExtendedSprite;

/**
 * ...
 * @author Hunter
 */
class WindowItem extends FlxExtendedSprite
{
	public var windowPos:FlxPoint;

	public var subItems:FlxTypedSpriteGroup<WindowItem>;
	
	public function new(relativeX:Int, relativeY:Int, ?bitmapData:BitmapData)
	{
		super(null, null, bitmapData);
		windowPos = FlxPoint.get(relativeX, relativeY);
	}
}