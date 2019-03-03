package ui;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author Hunter
 */
class Window extends FlxSpriteGroup
{
	public var windowWidth:Int;
	public var windowHeight:Int;
	
	private var baseWindow:FlxExtendedSprite;
	private var closeBox:FlxExtendedSprite;
	private var titleBox:FlxSprite;
	private var footerBar:FlxSprite;
	
	private static var windowTopLeft:BitmapData;
	private static var windowTopMid:BitmapData;
	private static var windowTopRight:BitmapData;
	private static var windowBottomLeft:BitmapData;
	private static var windowBottomMid:BitmapData;
	private static var windowBottomRight:BitmapData;
	private static var windowX:BitmapData;
	
	public function new(title:String, width:Int, height:Int, ?x:Float=100, ?y:Float=100)
	{
		super(x, y);
		
		windowTopLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_top_left.png");
		windowTopMid = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_top_mid.png");
		windowTopRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_top_right.png");
		windowBottomLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_bottom_left.png");
		windowBottomMid = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_bottom_mid.png");
		windowBottomRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_bottom_right.png");
		windowX = Assets.getBitmapData("starboard:assets/interface/starboard/elements/window/window_x.png");
		
		baseWindow = new FlxExtendedSprite(0, 0, new BitmapData(width, height, true, 0x0));
		baseWindow.antialiasing = false;
		
		constructWindowBase();
		
		writeTitle(title);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		closeBox.x = baseWindow.x + baseWindow.width - 22;
		closeBox.y = baseWindow.y + 5;
		
		if (closeBox.isPressed)
		{
			this.visible = false;
		}
	}
	
	private function constructWindowBase():Void
	{
		var destPoint:Point = new Point(0, 0);
		
		closeBox = new FlxExtendedSprite(0, 0, new BitmapData(9, 9, true, 0x0));
		closeBox.width = 9;
		closeBox.height = 9;
		
		closeBox.pixels.copyPixels(windowX, windowX.rect, new Point(0, 0));
		
		closeBox.x = 178;
		closeBox.y = 5;
		
		titleBox = new FlxSprite(0, 0, new BitmapData(Math.ceil(baseWindow.width), 35, true, 0x0));
		titleBox.width = baseWindow.width;
		titleBox.height = 35;
		
		titleBox.pixels.copyPixels(windowTopLeft, windowTopLeft.rect, new Point(0, 0));
		
		destPoint.x = 21;
		destPoint.y = 2;
		
		for (i in 0...(Math.ceil(baseWindow.width) - (2 * 21)))
		{
			titleBox.pixels.copyPixels(windowTopMid, windowTopMid.rect, destPoint);
			destPoint.x++;
		}
		
		destPoint.y = 0;
		
		titleBox.pixels.copyPixels(windowTopRight, windowTopRight.rect, destPoint);
		
		footerBar = new FlxSprite(0, 0, new BitmapData(Math.ceil(baseWindow.width), 18, true, 0x0));
		footerBar.width = baseWindow.width;
		footerBar.height = 18;
		
		footerBar.pixels.copyPixels(windowBottomLeft, windowBottomLeft.rect, new Point(2, 0));
		
		destPoint.x = 11;
		destPoint.y = footerBar.height - 6;
		
		for (i in 0...(Math.ceil(baseWindow.width) - (2 * 11)))
		{
			footerBar.pixels.copyPixels(windowBottomMid, windowBottomMid.rect, destPoint);
			destPoint.x++;
		}
		
		destPoint.y = 0;
		
		footerBar.pixels.copyPixels(windowBottomRight, windowBottomRight.rect, destPoint);
		
		destPoint.x = 6;
		destPoint.y = 35;
		
		baseWindow.pixels.fillRect(new Rectangle(destPoint.x + 1, (destPoint.y - 18) + 1, baseWindow.width - (2 * 7), baseWindow.height - (destPoint.y - 18)), 0xFFE9E8E1);
		
		baseWindow.pixels.fillRect(new Rectangle(destPoint.x, destPoint.y, 1, baseWindow.height - (footerBar.height + titleBox.height)), 0xFF363422);
		baseWindow.pixels.fillRect(new Rectangle(baseWindow.width - (destPoint.x + 2), destPoint.y, 1, baseWindow.height - (footerBar.height + titleBox.height)), 0xFF363422);
		
		baseWindow.stamp(titleBox, 0, 0);
		baseWindow.stamp(footerBar, 0, Math.ceil(baseWindow.height - footerBar.height));
		
		baseWindow.enableMouseDrag(false, true, 255, null, null);
		
		add(baseWindow);
		add(closeBox);
	}
	
	private function writeTitle(title:String):Void
	{
		var title:FlxText = new FlxText(0, 0, 0, title, 8);
		title.antialiasing = false;
		title.color = 0xFF3A1E03;
		
		baseWindow.stamp(title, 18, 3);
	}
}