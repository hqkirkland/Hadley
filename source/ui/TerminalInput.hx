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
class TerminalInput extends FlxSprite
{
	public var textInput:TextField;
	
	private static var zeroPoint:Point = new Point(0, 0);
	
	public function new(?foregroundColor:UInt=0xFFFFFF, ?backgroundColor:UInt=0xFF000000, ?width:Float=350, ?height:Float=200, ?x:Float=0, ?y:Float=0)
	{
		super(x, y);
		
		this.visible = false;
		textInput = new TextField();
		textInput.type = TextFieldType.INPUT;
		
		#if flash
		textInput.defaultTextFormat = new TextFormat("Arial", 20, foregroundColor, false, null, null, null, null, null, 5, null, null, 1);
		#else
		textInput.setTextFormat(new TextFormat("Arial", 20, foregroundColor, false, null, null, null, null, null, 5, null, null, 1));
		#end
		
		textInput.antiAliasType = AntiAliasType.NORMAL;
		textInput.multiline = true;
		textInput.background = true;
		textInput.backgroundColor = backgroundColor;
		textInput.x = this.x + 200;
		textInput.y = this.y + 200;
	}
	
	public function addElements():Void
	{
		FlxG.stage.addChild(textInput);
	}
	
	public function removeElements():Void
	{
		FlxG.stage.removeChild(textInput);
	}
}