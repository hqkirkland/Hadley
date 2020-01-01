package ui;

import haxe.io.Input;

import openfl.Assets;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author Hunter
 */
class LoginInputBox extends FlxSprite
{
	public var textInput:TextField;
	public var newInput:TextField;

	private var isPasswordBox:Bool = false;
	
	public function new(color:UInt, ?hideValue:Bool=false) 
	{
		super();
		
		isPasswordBox = hideValue;
		
		var sprite:FlxSprite = new FlxSprite();
		
		sprite.loadGraphic("assets/interface/login/images/emptyBox.png");
		sprite.pixels.threshold(sprite.pixels, sprite.pixels.rect, _flashPointZero, "==", 0xFF00FF00, color);
		
		this.pixels = sprite.pixels;
	}
	
	public function addElements():Void
	{
		textInput = new TextField();
		textInput.type = TextFieldType.INPUT;
		textInput.setTextFormat(new TextFormat(Assets.getFont("assets/interface/fonts/HelveticaRounded-Bold.otf").fontName, 14, 0xFF34363A, true, false, false));
		textInput.x = this.x + 5;
		textInput.y = this.y + 5;
		textInput.width = 225;
		textInput.height = 21;
		textInput.antiAliasType = AntiAliasType.NORMAL;
		textInput.background = false;
		textInput.border = false;
		textInput.displayAsPassword = isPasswordBox;
		
		FlxG.stage.addChild(textInput);
	}
	
	public function removeElements():Void
	{
		FlxG.stage.removeChild(textInput);
	}
}