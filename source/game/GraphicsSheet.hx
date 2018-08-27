package game;
import openfl.display.BitmapData;
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
	
	// Item replacement colors.
	private static var itemColors:Array<Array<Int>> = 
	[
		[ 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000 ],
		[ 0xFF111111, 0xFF222222, 0xFF333333, 0xFF444444 ],
		[ 0xFF2B3271, 0xFF5D8CEC, 0xFF96BFF6, 0xFFA5CCFF ]
	];
	
	private static var hairColors:Array<Array<Int>> = 
	[
		[ 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000 ],
		[ 0xFF0D0602, 0xFF1E0D05, 0xFF341A09, 0xFF57330F ]
	];
	
	private static var skinColors:Array<Array<Int>> = 
	[
		[ 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000 ]
	];
	
	// Palettes.
	private static var greenPalette:Array<Int> = [ 0xFF003300, 0xFF009900, 0xFF33CC33, 0xFF66FF66 ];
	private static var bluePalette:Array<Int>  = [ 0xFF003366, 0xFF0066CC, 0xFF0099FF, 0xFF33CCFF ];
	private static var hairPalette:Array<Int>  = [ 0xFF666633, 0xFFCCCC66, 0xFFFFFF99, 0xFFFFFFFF ];
	private static var skinPalette:Array<Int>  = [ 0xFF663300, 0xFFCC9966, 0xFFFFCC99, 0xFFFFFFCC ];
	
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
	
	public function colorItem(itemBitmap:BitmapData, colorNumber:Int, typeNumber:Int):BitmapData
	{
		// No color shift for item.
		if (colorNumber == 0)
		{
			return itemBitmap;
		}
		
		// Skin.
		if (typeNumber == 0)
		{
			for (n in 0...skinPalette.length)
			{
				var replacementColor:Int = skinColors[colorNumber][n];
				itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", skinPalette[n], replacementColor);
			};
		}
		
		else if (typeNumber == 1)
		{
			for (n in 0...hairPalette.length)
			{
				var replacementColor:Int = hairColors[colorNumber][n];
				itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", hairPalette[n], replacementColor);
			}
		}
		
		// Item.
		else if (typeNumber == 2)
		{
			for (n in 0...greenPalette.length)
			{
				var replacementColor:Int = itemColors[colorNumber][n];
				itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", greenPalette[n], replacementColor);
			}
			
			for (n in 0...bluePalette.length)
			{
				var replacementColor:Int = itemColors[colorNumber][n];
				itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", bluePalette[n], replacementColor);
			}
		}
		
		return itemBitmap;
	}
}