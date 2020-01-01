package ui;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.filters.DropShadowFilter;
import openfl.geom.Matrix;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;

import flixel.FlxSprite;
/**
 * ...
 * @author Hunter
 */
class NoticeBox extends FlxSprite
{
	public var backgroundShape:Shape;
	private static var titleFormat:TextFormat;
	
	public function new(width:Int, height:Int, ?title:String=null, ?ellipseWidth:Int=20) 
	{
		super();
		
		titleFormat = new TextFormat(Assets.getFont("assets/interface/fonts/HelveticaRoundedLT-Black.otf").fontName, 14, 0x34363A, false);
		
		backgroundShape = new Shape();
		backgroundShape.graphics.beginFill(0xFFFFFF);
		backgroundShape.graphics.drawRoundRect(0, 0, width, height, ellipseWidth);
		
		this.pixels = new BitmapData(Math.ceil(backgroundShape.width + 10), Math.ceil(backgroundShape.height + 10), true, 0x0);
		this.pixels.draw(backgroundShape);		
		
		if (title != null)
		{
			var titleBox:TextField = new TextField();
			titleBox.type = TextFieldType.DYNAMIC;
			titleBox.text = title;
			
			titleBox.setTextFormat(titleFormat);
			
			this.pixels.draw(titleBox, new Matrix(1, 0, 0, 1, 15, 15));
		}
	}
}