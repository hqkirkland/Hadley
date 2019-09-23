package ui;

import openfl.Assets;
import openfl.geom.Point;
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
		
		#if flash
		textInput.defaultTextFormat = new TextFormat("Arial", 14, 0x34363A, true);
		textInput.y = this.y + 5;
		#else
		//textInput.setTextFormat(new TextFormat(Assets.getFont("assets/interface/fonts/HelveticaRoundedLT-Black.otf").fontName, 14, 0x34363A, false, null, null, null, null, null, 12, null, null, 1));
		textInput.y = this.y + 5;
		#end
		
		textInput.width = 225;
		textInput.height = 21;
		textInput.antiAliasType = AntiAliasType.NORMAL;
		textInput.multiline = false;
		textInput.background = false;
		
		textInput.x = this.x + 5;
		
		//textInput.displayAsPassword = isPasswordBox;
		
		FlxG.stage.addChild(textInput);
	}
	
	public function removeElements():Void
	{
		FlxG.stage.removeChild(textInput);
	}
}