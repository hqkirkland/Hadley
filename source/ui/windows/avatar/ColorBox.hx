package ui.windows.avatar;

import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;

import game.GraphicsSheet;
import game.items.ItemColor;

/**
 * ...
 * @author Hunter
 */

class ColorBox extends WindowItem
{
	public var itemColor:ItemColor;

	private static var zeroPoint:Point = new Point(0, 0);
	public function new(?relativeX:Int=0, ?relativeY:Int=0, itemColor:ItemColor)
	{
		this.itemColor = itemColor;
		var colorBoxKey:String = itemColor.colorId + ": " + itemColor.channel1 + ", " + itemColor.channel2 + ", " + itemColor.channel3 + ", " + itemColor.channel4;
		trace(colorBoxKey);
		var colorBoxBmp:BitmapData = Assets.getBitmapData("starboard:assets/interface/starboard/elements/color_box.png", false);
		colorBoxBmp = GraphicsSheet.colorItem(colorBoxBmp, itemColor.colorId, GraphicsSheet.itemTypeToColorType(itemColor.itemType), false);
		
		super(relativeX, relativeY);
		loadGraphic(colorBoxBmp, false, colorBoxBmp.width, colorBoxBmp.height, true, colorBoxKey);

		/*
		trace("Color ID #" + itemColor.colorId);
		trace("Channel1: " + itemColor.channel1);
		trace("Channel2: " + itemColor.channel2);
		trace("Channel3: " + itemColor.channel3);
		trace("Channel4: " + itemColor.channel4);
		*/

	}


	public function changeBoxColor(itemColor:ItemColor)
	{
		this.itemColor = itemColor;
		trace("Changing color to:" + itemColor.colorId + ": " + itemColor.channel1);

		var colorBoxBmp:BitmapData = Assets.getBitmapData("starboard:assets/interface/starboard/elements/color_box.png", false);
		colorBoxBmp = GraphicsSheet.colorItem(colorBoxBmp, itemColor.colorId, GraphicsSheet.itemTypeToColorType(itemColor.itemType), true);
		
		trace("Color ID #" + itemColor.colorId);
		trace("Channel1:" + itemColor.channel1);
		trace("Channel2:" + itemColor.channel2);
		trace("Channel3:" + itemColor.channel3);
		trace("Channel4:" + itemColor.channel4);

		this.pixels.copyPixels(colorBoxBmp, colorBoxBmp.rect, zeroPoint);
	}

	override public function mousePressedHandler():Void
	{
		super.mousePressedHandler();

		trace("ColorBox Clicked: " + haxe.Json.stringify(itemColor));

		RoomState.starboard.avatarWindow.colorList.changeColor(itemColor.colorId);
	}

	//override public function mousePressedCallback(box:ColorBox, )
}