package ui;

import flash.geom.Point;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.util.FlxColor;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.graphics.FlxGraphic;
import flixel.addons.ui.FlxUI9SliceSprite;

/**
 * ...
 * @author Hunter
 */
class SubmitButton extends FlxButton
{
	public var button:FlxButton;
	
	private var buttonWidth:Int;
	private var buttonHeight:Int;
	private var buttonBmp:BitmapData;
	private var titleFormat:TextFormat = new TextFormat(Assets.getFont("assets/interface/fonts/HelveticaRoundedLT-Black.otf").fontName, 16, 0xFFFFFF, false);
	
	private static var buttonSlice:FlxUI9SliceSprite;
	private static var buttonPressedSlice:FlxUI9SliceSprite;
	
	public function new(_width:Int, _height:Int, title:String, onClick:Void->Void)
	{
		super(0, 0, null, onClick);
		
		buttonWidth = _width;
		buttonHeight = _height;
		
		var titleBox:TextField = new TextField();
		titleBox.type = TextFieldType.DYNAMIC;
		titleBox.text = title;
		titleBox.setTextFormat(titleFormat);
		
		buttonBmp = new BitmapData(buttonWidth * 3, buttonHeight * 3, true, 0x0);
		
		var count:Int = 1;
		var parts:Array<String> = [ "", "_hover", "_press" ];
		var srcRectangle:Rectangle = new Rectangle(0, 0, buttonWidth, buttonHeight);
		var m:Matrix = new Matrix(1, 0, 0, 1, (buttonWidth * 0) + ((buttonWidth / 2) - (titleBox.textWidth / 2) - 3), (buttonHeight / 2) - (titleBox.textHeight / 2));

		for (state in parts)
		{
			var bmp:BitmapData = FlxGraphic.fromAssetKey("assets/interface/login/images/greenButton" + state + ".png").bitmap;
			var buttonSlice:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, 0, bmp, srcRectangle, [ 11, 11, 13, 13 ]);
			
			buttonBmp.copyPixels(buttonSlice.pixels, srcRectangle, new Point(buttonWidth * (count - 1), 0));
			
			buttonSlice.destroy();
			
			buttonBmp.draw(titleBox, m);
			m.tx = m.tx + buttonWidth;
			
			count++;
		}
		
		this.loadGraphic(FlxGraphic.fromBitmapData(buttonBmp), true, buttonWidth, buttonHeight);
	}
}