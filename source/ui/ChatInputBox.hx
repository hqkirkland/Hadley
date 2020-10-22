package ui;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIInputText;

import openfl.Assets;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;

/**
 * ...
 * @author Hunter
 */
class ChatInputBox extends FlxSprite
{
	public var textInput:TextField;
	public var newTextInput:FlxUIInputText;
	
	private static var zeroPoint:Point = new Point(0, 0);
	
	public function new(?foregroundColor:UInt=0x000000, ?x:Float=0, ?y:Float=0)
	{
		super(x, y, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_chat_box.png"));
		
		textInput = new TextField();
		textInput.type = TextFieldType.INPUT;
		textInput.width = 220;
		textInput.height = 21;
		textInput.antiAliasType = AntiAliasType.NORMAL;
		textInput.setTextFormat(new TextFormat("Arial", 8, foregroundColor, null, null, null, null, null, null, 5, null, null, 1));
		textInput.background = false;
		textInput.backgroundColor = 0xE8E1B1;
		textInput.multiline = false;
		textInput.selectable = true;
		textInput.autoSize = TextFieldAutoSize.NONE;
		
		FlxG.stage.addChild(textInput);
		
		textInput.x = 365;
		textInput.y = 511 + Math.ceil(textInput.height / 2);
	}
	
	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	public function removeElements():Void
	{
		FlxG.stage.removeChild(textInput);
	}
}