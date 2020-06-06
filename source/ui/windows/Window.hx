package ui.windows;

import openfl.display.Bitmap;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

import flixel.addons.display.FlxExtendedSprite;
import flixel.graphics.FlxGraphic;
import flixel.text.FlxText;

/**
 * ...
 * @author Hunter
 */
class Window extends FlxExtendedSprite
{
	public var windowTitle:String;
	public var windowWidth:Int;
	public var windowHeight:Int;
	
	private var baseWindowBmpData:BitmapData;
	private static var windowTopLeft:BitmapData;
	private static var windowTopMid:BitmapData;
	private static var windowTopRight:BitmapData;
	private static var windowBottomLeft:BitmapData;
	private static var windowBottomMid:BitmapData;
	private static var windowBottomRight:BitmapData;
	private static var windowX:BitmapData;
	
	public function new(title:String, width:Int, height:Int, ?x:Float=0, ?y:Float=0)
	{
	
		windowTitle = title;
		windowWidth = width;
		windowHeight = height;

		windowTopLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_top_left.png");
		windowTopMid = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_top_mid.png");
		windowTopRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_top_right.png");
		windowBottomLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_bottom_left.png");
		windowBottomMid = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_bottom_mid.png");
		windowBottomRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_bottom_right.png");
		windowX = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_x.png");

		constructWindowBase();

		super(x, y, baseWindowBmpData);
		this.x = x;
		this.y = y;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
	
	private function closeWindow():Void
	{
		this.visible = false;
	}

	private function constructWindowBase():Void
	{
		var destPoint:Point = new Point(0, 0);		
		baseWindowBmpData = new BitmapData(windowWidth, windowHeight, true, 0x0);

		destPoint.setTo(0, 0);
		baseWindowBmpData.copyPixels(windowTopLeft, windowTopLeft.rect, destPoint);

		destPoint.setTo(windowWidth - windowTopRight.width, 0);
		baseWindowBmpData.copyPixels(windowTopRight, windowTopRight.rect, destPoint);

		writeTitle(windowTitle);

		destPoint.setTo(0, windowHeight - windowBottomLeft.height);
		baseWindowBmpData.copyPixels(windowBottomLeft, windowBottomLeft.rect, destPoint);

		destPoint.setTo(windowWidth - windowBottomRight.width, windowHeight - windowBottomRight.height);
		baseWindowBmpData.copyPixels(windowBottomRight, windowBottomRight.rect, destPoint);
	}
	
	private function writeTitle(title:String):Void
	{
		var title:FlxText = new FlxText(0, 0, 0, title, 8);
		title.antialiasing = false;
		title.color = 0xFF3A1E03;
		title.draw();
		
		baseWindowBmpData.copyPixels(title.pixels, title.pixels.rect, new Point(18, 3));
	}
}