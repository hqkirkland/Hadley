package ui;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.filters.DropShadowFilter;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;

import flixel.FlxSprite;
import flixel.addons.ui.FlxUI9SliceSprite;
/**
 * ...
 * @author Hunter
 */
class SubmitButton extends FlxSprite
{
	public var backgroundShape:Shape;
	
	public function new(width:Int, height:Int, ?title:String=null) 
	{
		super();
		
		this.loadGraphicFromSprite(new FlxUI9SliceSprite(0, 0, Assets.getBitmapData("assets/interface/login/images/greenButton.png"),
								   new Rectangle(this.x, this.y, width, height),
								   [ 11, 11, 13, 13 ]));
		
		if (title != null)
		{
			var titleBox:TextField = new TextField();
			titleBox.type = TextFieldType.DYNAMIC;
			titleBox.text = title;
			
			#if flash
			// So for some reason you have to use SET with dynamic on Flash.
			titleBox.setTextFormat(new TextFormat("Arial", 14, 0xFFFFFF, true));
			#else
			titleBox.setTextFormat(new TextFormat(Assets.getFont("assets/interface/text/HelveticaRounded-Bold.otf").fontName, 18, 0xFFFFFF, true));
			#end
			
			this.pixels.draw(titleBox, new Matrix(1, 0, 0, 1, (this.width / 2) - 20, (this.height / 2) - 7));
		}
	}
	
	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}