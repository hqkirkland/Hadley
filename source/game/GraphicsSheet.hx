package game;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.geom.Point;

import game.ItemColor;

/**
 * ...
 * @author Hunter
 */
class GraphicsSheet extends Bitmap
{
	private static var zeroPoint:Point = new Point(0, 0);
	private static var staticPoint:Point = new Point(0, 0);
	
	// Item replacement colors.
	public static var avatarColors:Map<Int, ItemColor> = new Map();
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
	
	public static function colorItem(itemBitmap:BitmapData, colorNumber:Int, typeNumber:Int):BitmapData
	{
		// No color shift for item.
		if (colorNumber == 0)
		{
			return itemBitmap;
		}
		
		var replacementColor:ItemColor = avatarColors[colorNumber];
		
		// Skin.
		if (typeNumber == 0)
		{
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", skinPalette[0], replacementColor.channel1);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", skinPalette[1], replacementColor.channel2);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", skinPalette[2], replacementColor.channel3);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", skinPalette[3], replacementColor.channel4);
			
			/*
			for (n in 0...skinPalette.length)
			{
				var replacementColor:Int = itemColors[n];
				itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", skinPalette[n], replacementColor);
			};
			*/
		}
		
		// Hair.
		else if (typeNumber == 1)
		{
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", hairPalette[0], replacementColor.channel1);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", hairPalette[1], replacementColor.channel2);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", hairPalette[2], replacementColor.channel3);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", hairPalette[3], replacementColor.channel4);
			
			/*
			for (n in 0...hairPalette.length)
			{
				var replacementColor:Int = hairColors[colorNumber][n];
				itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", hairPalette[n], replacementColor);
			}
			*/
		}
		
		// Item.
		else if (typeNumber == 2)
		{
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", greenPalette[0], replacementColor.channel1);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", greenPalette[1], replacementColor.channel2);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", greenPalette[2], replacementColor.channel3);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", greenPalette[3], replacementColor.channel4);
			
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", bluePalette[0], replacementColor.channel1);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", bluePalette[1], replacementColor.channel2);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", bluePalette[2], replacementColor.channel3);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", bluePalette[3], replacementColor.channel4);
			
			/*
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
			*/
		}
		
		return itemBitmap;
	}
}