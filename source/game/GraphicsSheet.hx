package game;
import hxColorToolkit.ColorToolkit;
import hxColorToolkit.spaces.HSL;
import hxColorToolkit.spaces.ARGB;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.display.Bitmap;
import openfl.utils.Dictionary;

/**
 * ...
 * @author Hunter
 */
class GraphicsSheet extends Bitmap
{
	private static var zeroPoint:Point = new Point(0, 0);
	private static var staticPoint:Point = new Point(0, 0);
	private static var greenPalette:Array<Int> = [ 0xFF003300, 0xFF009900, 0xFF33CC33, 0xFF66FF66 ];
	private static var bluePalette:Array<Int> =  [ 0xFF003366, 0xFF0066CC, 0xFF0099FF, 0xFF33CCFF ];
	
	//private static var paletteTransformations:Dictionary<Int, Array<Int
	
	public function new(width:Int, height:Int) 
	{
		super();
		this.bitmapData = new BitmapData(width, height, true, 0x00000000);
	}
		
	public function drawItem(itemBitmap:BitmapData, dx:Int=0, dy:Int=0):Void
	{
		staticPoint.x = dx;
		staticPoint.y = dy;
		
		// First remove green.
		itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", 0xFF00FF00);
		// Copy pixels to main sheet.
		this.bitmapData.copyPixels(itemBitmap, this.bitmapData.rect, staticPoint, null, null, true);
		// Remove red AFTER overlay, 
		// trimming any pixles that got replaced with a pure red channel.
		this.bitmapData.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", 0xFFFF0000);
	}
	
	public function colorItem(itemBitmap:BitmapData, color:Int):BitmapData
	{
		for (replacementColor in greenPalette)
		{
			var colorT:UInt = calculateColor(replacementColor);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", replacementColor, colorT);
		}
		
		for (replacementColor in bluePalette)
		{
			var colorT:UInt = calculateColor(replacementColor);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", replacementColor, colorT);
		}
		
		return itemBitmap;
	}
	
	private static function calculateColor(baseColor:Int):UInt
	{
		var hslColor:HSL = ColorToolkit.toHSL(baseColor);
		hslColor.hue = 0;
		hslColor.saturation = 0;
		hslColor.lightness *= .4;
		
		var argbColor:ARGB = ColorSpaceToolkit.toARGB(hslColor);
		
		// trace(hslColor.hue + ", " + hslColor.saturation + ", " + hslColor.lightness);
		// trace(rgbColor.red + ", " + rgbColor.green + ", " + rgbColor.blue)
		// trace(argbColor.getColor());
		
		return argbColor.getColor();
	}
}