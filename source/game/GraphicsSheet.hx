package game;
import flash.display.BitmapData;
import openfl.geom.Point;
import openfl.display.Bitmap;

/**
 * ...
 * @author Hunter
 */
class GraphicsSheet extends Bitmap
{
	private static var zeroPoint:Point = new Point(0, 0);
	private static var staticPoint:Point = new Point(0, 0);
	
	public function new(width:Int, height:Int) 
	{
		super();
		this.bitmapData = new BitmapData(width, height, true, 0x00000000);
	}
		
	public function drawItem(itemBitmap:BitmapData, dx:Int=0, dy:Int=0):Void
	{
		staticPoint.x = dx;
		staticPoint.y = dy;
		
		this.bitmapData.copyPixels(clipItem(itemBitmap), this.bitmapData.rect, staticPoint, null, null, true);
	}
	
	public function clipItem(itemBitmap:BitmapData):BitmapData
	{
		itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", 0xFF00FF00);
		itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", 0xFFFF0000);
		
		return itemBitmap;
	}
}