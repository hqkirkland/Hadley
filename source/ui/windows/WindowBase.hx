package ui.windows;

import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.addons.plugin.FlxMouseControl;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.util.FlxSort;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Hunter
 */
class WindowBase extends WindowItem
{
	private var windowTitle:String;

	private var baseWindowBmpData:BitmapData;
	private var windowWidth:Int;
	private var windowHeight:Int;

	private var windowCloseRect:FlxRect;

	private static var windowTopLeft:BitmapData;
	private static var windowTopMid:BitmapData;
	private static var windowTopRight:BitmapData;
	private static var windowBottomLeft:BitmapData;
	private static var windowBottomMid:BitmapData;
	private static var windowBottomRight:BitmapData;
	private static var windowClose:BitmapData;

	private var isItemList:Bool = false;

	public function new(title:String, _windowWidth:Int, _windowHeight:Int, ?drawBorders:Bool = true, ?baseWindowBitmapData:BitmapData)
	{
		windowTitle = title;
		windowWidth = _windowWidth;
		windowHeight = _windowHeight;
		baseWindowBmpData = (baseWindowBitmapData == null) ? new BitmapData(windowWidth, windowHeight, false, 0xFFFFFFFF) : baseWindowBitmapData;

		if (!drawBorders)
		{
			super(0, 0, baseWindowBmpData);
			isItemList = true;
		}
		else
		{
			drawRoyalBorders();
			super(0, 0, baseWindowBmpData);
			writeTitle(title);
		}

		updateHitbox();
	}

	private function drawRoyalBorders()
	{
		windowTopLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_top_left.png");
		windowTopMid = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_top_mid.png");
		windowTopRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_top_right.png");
		windowBottomLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_bottom_left.png");
		windowBottomMid = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_bottom_mid.png");
		windowBottomRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_bottom_right.png");
		windowClose = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_x.png");

		constructWindowBase();
	}

	override public function mousePressedHandler()
	{
		super.mousePressedHandler();
		StarboardInterface.bringToFront(this);
	}

	private function constructWindowBase():Void
	{
		var footerMarginPixels:Int = 3;
		var marginOffset:Int = 7;

		var destPoint:Point = new Point(0, 0);
		baseWindowBmpData = new BitmapData(windowWidth, windowHeight, true, 0x0);

		var parchmentBmpBackground:BitmapData = new BitmapData(windowWidth - 14, windowHeight - 21, true, 0xFFE9E8E1);

		destPoint.setTo(7, 15);
		baseWindowBmpData.copyPixels(parchmentBmpBackground, parchmentBmpBackground.rect, destPoint, null, null, true);

		destPoint.setTo(0, 0);
		baseWindowBmpData.copyPixels(windowTopLeft, windowTopLeft.rect, destPoint, null, null, true);

		var titleBarWidth:Int = windowWidth - (windowTopLeft.width + windowTopRight.width);

		for (x in 0...titleBarWidth)
		{
			destPoint.setTo(windowTopLeft.width + x, 2);
			baseWindowBmpData.copyPixels(windowTopMid, windowTopMid.rect, destPoint);
		}

		destPoint.setTo(windowWidth - windowTopRight.width, 0);
		baseWindowBmpData.copyPixels(windowTopRight, windowTopRight.rect, destPoint, null, null, true);

		destPoint.setTo(footerMarginPixels, windowHeight - windowBottomLeft.height);
		baseWindowBmpData.copyPixels(windowBottomLeft, windowBottomLeft.rect, destPoint, null, null, true);

		var borderHeight:Int = 0;
		borderHeight = windowHeight - (windowTopLeft.height + windowBottomLeft.height);

		for (y in 0...borderHeight)
		{
			baseWindowBmpData.setPixel32(marginOffset, windowTopLeft.height + y, 0xFF363422);
			baseWindowBmpData.setPixel32(windowWidth - marginOffset - 1, windowTopRight.height + y, 0xFF363422);
		}

		var footerBarWidth = windowWidth - (windowBottomLeft.width + windowBottomRight.width + (footerMarginPixels * 2));

		for (x in 0...footerBarWidth)
		{
			destPoint.setTo(windowBottomLeft.width + x + footerMarginPixels, windowHeight - windowBottomMid.height);
			baseWindowBmpData.copyPixels(windowBottomMid, windowBottomMid.rect, destPoint);
		}

		destPoint.setTo(windowWidth - windowBottomRight.width - footerMarginPixels, windowHeight - windowBottomRight.height);
		baseWindowBmpData.copyPixels(windowBottomRight, windowBottomRight.rect, destPoint, null, null, true);
	}

	private function writeTitle(titleString:String):Void
	{
		var title:FlxText = new FlxText(0, 0, 0, titleString, 8);
		title.antialiasing = false;
		title.color = 0xFF3A1E03;
		title.draw();
		stamp(title, 18, 3);
	}
}
