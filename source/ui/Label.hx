package ui;

import openfl.Assets;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Hunter
 */
class Label extends FlxSprite
{
	public var textBox:TextField;
	private var _textSize:Int;
	
	public function new(textSize:Int=14) 
	{
		super();
		this.makeGraphic(100, 20, FlxColor.TRANSPARENT);
		
		_textSize = textSize;
	}
	
	public function addText(text:String)
	{
		if (textBox != null)
		{
			FlxG.stage.removeChild(textBox);
		}
		
		textBox = new TextField();
		textBox.type = TextFieldType.DYNAMIC;
		textBox.text = text;
		#if flash
		// So for some reason you have to use SET with dynamic on Flash.
		textBox.setTextFormat(new TextFormat("Arial", _textSize, 0x34363A, true));
		#else
		textBox.setTextFormat(new TextFormat(Assets.getFont("assets/interface/text/HelveticaRounded-Bold.otf").fontName, _textSize, 0x34363A, false));
		#end
		textBox.width = 100;
		textBox.height = 20;
		textBox.background = false;
		FlxG.stage.addChild(textBox);
	}
	
	override function update(elapsed:Float):Void
	{
		if (this.textBox != null)
		{
			this.textBox.x = this.x;
			this.textBox.y = this.y;
		}
		
		super.update(elapsed);
	}
}