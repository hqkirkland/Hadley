package ui;

import openfl.Assets;
import openfl.geom.Point;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.display.BitmapData;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author Hunter
 */
class ChatInputBox extends FlxSprite
{
	public var textInput:TextField;
	
	private static var zeroPoint:Point = new Point(0, 0);
	private static var staticPoint:Point = new Point(0, 0);	
	
	public function new(?foregroundColor:UInt=0x000000, ?backgroundColor:UInt=0xFFFFFF)
	{
		super();
		
		this.pixels = new BitmapData(1, 1, true, 0x0);
		
		textInput = new TextField();
		textInput.type = TextFieldType.INPUT;
		
		#if flash
		textInput.defaultTextFormat = new TextFormat("Arial", 14, foregroundColor, true);
		#else
		textInput.setTextFormat(new TextFormat(Assets.getFont("assets/interface/fonts/HelveticaRoundedLT-Black.otf").fontName, 14, foregroundColor, false, null, null, null, null, null, 12, null, null, 1));
		#end
		
		textInput.width = 225;
		textInput.height = 21;
		textInput.antiAliasType = AntiAliasType.NORMAL;
		textInput.multiline = false;
		textInput.background = true;
		textInput.backgroundColor = backgroundColor;
		
		FlxG.stage.addChild(textInput);
	}
	
	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		textInput.x = this.x;
		textInput.y = this.y;
	}
	
	public function removeElements():Void
	{
		FlxG.stage.removeChild(textInput);
	}
}