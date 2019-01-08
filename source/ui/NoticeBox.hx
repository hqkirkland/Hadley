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
	
	public function new(width:Int, height:Int, ellipseWidth:Int, ?title:String=null) 
	{
		super();
		
		backgroundShape = new Shape();
		backgroundShape.graphics.beginFill(0xFFFFFF);
		backgroundShape.graphics.drawRoundRect(0, 0, width, height, ellipseWidth);
		
		var dropShadow:DropShadowFilter = new DropShadowFilter(4, 45, 0, 0.15, 6, 6);
		backgroundShape.filters = [ dropShadow ];
		this.pixels = new BitmapData(Math.ceil(backgroundShape.width + 10), Math.ceil(backgroundShape.height + 10), true, 0x0);
		this.pixels.draw(backgroundShape);
		
		if (title != null)
		{
			var titleBox:TextField = new TextField();
			titleBox.type = TextFieldType.DYNAMIC;
			titleBox.text = title;
			
			#if flash
			// So for some reason you have to use SET with dynamic on Flash.
			titleBox.setTextFormat(new TextFormat("Arial", 14, 0x34363A, true));
			#else
			titleBox.setTextFormat(new TextFormat(Assets.getFont("assets/interface/text/HelveticaRounded-Bold.otf").fontName, 14, 0x34363A, true));
			#end
			
			this.pixels.draw(titleBox, new Matrix(1, 0, 0, 1, 15, 15));
			//this.stamp(titleText, Math.ceil(this.x + 5), Math.ceil(this.y + 5));
		}		
	}
}