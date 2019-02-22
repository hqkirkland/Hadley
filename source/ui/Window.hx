package ui;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.text.AntiAliasType;
import openfl.text.TextFormat;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.addons.display.FlxExtendedSprite;

/**
 * ...
 * @author Hunter
 */
class Window extends FlxExtendedSprite
{
	public var windowWidth:Int;
	public var windowHeight:Int;
	
	private var titleBox:FlxSprite;
	private var footerBar:FlxSprite;
	private var closeBox:FlxSprite;
	
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
		
		this.pixels = new BitmapData(width, height, true, 0x0);
		this.antialiasing = false;
		
		constructWindowBase();
		writeTitle(title);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (this.isPressed)
		{
			if (FlxG.mouse.overlaps(this.closeBox))
			{
				this.visible = false;
			}
		}
	}
	
	private function constructWindowBase():Void
	{
		var destPoint:Point = new Point(0, 0);
		
		closeBox = new FlxSprite(0, 0, new BitmapData(9, 9, true, 0x0));
		closeBox.width = 9;
		closeBox.height = 9;
		
		closeBox.pixels.copyPixels(windowX, windowX.rect, new Point(0, 0));
		
		
		titleBox = new FlxSprite(0, 0, new BitmapData(Math.ceil(width), 35, true, 0x0));
		titleBox.width = this.width;
		titleBox.height = 35;
		
		titleBox.pixels.copyPixels(windowTopLeft, windowTopLeft.rect, new Point(0, 0));
		
		destPoint.x = 21;
		destPoint.y = 2;
		
		for (i in 0...(Math.ceil(this.width) - (2 * 21)))
		{
			titleBox.pixels.copyPixels(windowTopMid, windowTopMid.rect, destPoint);
			destPoint.x++;
		}
		
		destPoint.y = 0;
		
		titleBox.pixels.copyPixels(windowTopRight, windowTopRight.rect, destPoint);
		
		
		footerBar = new FlxSprite(0, 0, new BitmapData(Math.ceil(width), 18, true, 0x0));
		footerBar.width = this.width;
		footerBar.height = 18;
		
		footerBar.pixels.copyPixels(windowBottomLeft, windowBottomLeft.rect, new Point(2, 0));
		
		destPoint.x = 11;
		destPoint.y = footerBar.height - 6;
		
		for (i in 0...(Math.ceil(this.width) - (2 * 11)))
		{
			footerBar.pixels.copyPixels(windowBottomMid, windowBottomMid.rect, destPoint);
			destPoint.x++;
		}
		
		destPoint.y = 0;
		
		footerBar.pixels.copyPixels(windowBottomRight, windowBottomRight.rect, destPoint);
		
		
		destPoint.x = 6;
		destPoint.y = 35;
		
		this.pixels.fillRect(new Rectangle(destPoint.x + 1, (destPoint.y - 18) + 1, this.width - (2 * 7), this.height - (destPoint.y - 18)), 0xFFE9E8E1);
		
		this.pixels.fillRect(new Rectangle(destPoint.x, destPoint.y, 1, this.height - (footerBar.height + titleBox.height)), 0xFF363422);
		this.pixels.fillRect(new Rectangle(this.width - (destPoint.x + 2), destPoint.y, 1, this.height - (footerBar.height + titleBox.height)), 0xFF363422);
		
		stamp(titleBox, 0, 0);
		stamp(footerBar, 0, Math.ceil(this.height - footerBar.height));
		stamp(closeBox, 178, 5);

		this.enableMouseDrag(false, true, 255, null, null);
	}
	
	private function writeTitle(title:String):Void
	{
		var title:FlxText = new FlxText(0, 0, 0, title, 8);
		title.antialiasing = false;
		title.color = 0xFF3A1E03;
		
		stamp(title, 18, 3);
	}
}