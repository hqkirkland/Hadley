package ui;

import flixel.graphics.FlxGraphic;
import openfl.Assets;
import openfl.display.BitmapData;
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
	
	private var fontSize:Int;
	private var fontColor:Int;
	private var backgroundColor:Int = 0x0;
	
	public function new(text:String, textSize:Int=14, ?fgColor:Int=0xFF34363A, ?bgColor:Int=0x00000000) 
	{
		super();
		
		fontColor = fgColor;
		backgroundColor = bgColor;
		
		fontSize = textSize;
		textBox = new TextField();
		textBox.type = TextFieldType.DYNAMIC;
		
		#if flash
		var labelFormat:TextFormat = new TextFormat("Arial", fontSize, fontColor, true);
		#else
		var labelFormat:TextFormat = new TextFormat(Assets.getFont("assets/interface/fonts/HelveticaRoundedLT-Black.otf").fontName, fontSize, fontColor, false);
		#end
		
		textBox.width = (text.length + 1) * textSize;
		textBox.height = 20;
		textBox.background = false;
		textBox.setTextFormat(labelFormat);
		
		setText(text);
	}
	
	public function setText(text:String)
	{
		this.makeGraphic(Math.ceil(textBox.width), Math.ceil(textBox.height), FlxColor.fromInt(backgroundColor), true);
		textBox.text = text;
		this.pixels.draw(textBox);
	}
}