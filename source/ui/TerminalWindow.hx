package ui;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;

import flixel.FlxSprite;


/**
 * ...
 * @author Hunter
 */
class TerminalWindow extends Window
{
	private static var consoleContainer:FlxSprite;
	private static var terminalText:TerminalInput;
	
	private static var consoleCornerTopRight:BitmapData;
	private static var consoleCornerTopLeft:BitmapData;
	private static var consoleCornerBottomRight:BitmapData;
	private static var consoleCornerBottomLeft:BitmapData;
		
	public function new() 
	{
		super("RangerNet", 400, 250, 175, 100);
		
		consoleCornerTopRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/console/console_corner_rounded_top_right.png");
		consoleCornerTopLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/console/console_corner_rounded_top_left.png");
		consoleCornerBottomRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/console/console_corner_rounded_bottom_right.png");
		consoleCornerBottomLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/console/console_corner_rounded_bottom_left.png");
		
		terminalText = new TerminalInput(0xFFFFFF, 0xFF000000, 400, 250);
		
		makeContainer();
		terminalText.textInput.width = consoleContainer.width - 10;
		terminalText.textInput.height = consoleContainer.height - 10;
		
		add(terminalText);
		terminalText.addElements();
	}
	
	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		consoleContainer.x = baseWindow.x + 12;
		consoleContainer.y = baseWindow.y + 60;
		
		terminalText.textInput.x = baseWindow.x;
		terminalText.textInput.y = baseWindow.y;
	}
	
	private function makeContainer():Void
	{
		consoleContainer = new FlxSprite(12, 60);
		consoleContainer.pixels = new BitmapData(Math.floor(this.baseWindow.width) - 24, Math.ceil(this.baseWindow.height - 60 - 34), true, 0xFF000000);
		
		consoleContainer.pixels.copyPixels(consoleCornerTopLeft, consoleCornerTopLeft.rect, new Point(0, 0), null, null, true); 
		consoleContainer.pixels.copyPixels(consoleCornerTopRight, consoleCornerTopRight.rect, new Point(consoleContainer.width - 5, 0), null, null, true);
		consoleContainer.pixels.copyPixels(consoleCornerBottomLeft, consoleCornerBottomLeft.rect, new Point(0, consoleContainer.height - 5), null, null, true);
		consoleContainer.pixels.copyPixels(consoleCornerBottomRight, consoleCornerBottomRight.rect, new Point(consoleContainer.width - 5, consoleContainer.height - 5), null, null, true); 
		
		consoleContainer.pixels.threshold(consoleContainer.pixels, consoleContainer.pixels.rect, new Point(0, 0), "==", 0xFF00FF00);
		
		for (y in 5...(consoleContainer.pixels.height - 5))
		{
			consoleContainer.pixels.setPixel32(0, y, 0xFF989370);
			consoleContainer.pixels.setPixel32(consoleContainer.pixels.width - 1, y, 0xFF989370);
		}
		
		for (x in 5...(consoleContainer.pixels.width - 5))
		{
			consoleContainer.pixels.setPixel32(x, 0, 0xFF989370);
			consoleContainer.pixels.setPixel32(x, consoleContainer.pixels.height - 1, 0xFF989370);
		}
		
		add(consoleContainer);
	}
}