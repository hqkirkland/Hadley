package ui;

import openfl.Assets;
import openfl.geom.Point;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;

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
	
	public function new(?foregroundColor:UInt=0x000000, ?x:Float=0, ?y:Float=0)
	{
		super(x, y, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_chat_box.png"));
		
		textInput = new TextField();
		textInput.type = TextFieldType.INPUT;
		
		#if flash
		textInput.defaultTextFormat = new TextFormat("Arial", 14, foregroundColor, true);
		#else
		textInput.setTextFormat(new TextFormat("Arial", 14, foregroundColor, false, null, null, null, null, null, 12, null, null, 1));
		#end
		
		textInput.width = 225;
		textInput.height = 21;
		textInput.antiAliasType = AntiAliasType.NORMAL;
		textInput.multiline = false;
		textInput.background = false;
		textInput.x = this.x;
		textInput.y = this.y;
		
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