package game;

import game.items.ItemColor;
import game.items.GameItemType;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Point;

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
	private static var greenPalette:Array<Int> = [0xFF003300, 0xFF009900, 0xFF33CC33, 0xFF66FF66];
	private static var bluePalette:Array<Int> = [0xFF003366, 0xFF0066CC, 0xFF0099FF, 0xFF33CCFF];
	private static var hairPalette:Array<Int> = [0xFF666633, 0xFFCCCC66, 0xFFFFFF99, 0xFFFFFFFF];
	private static var skinPalette:Array<Int> = [0xFF663300, 0xFFCC9966, 0xFFFFCC99, 0xFFFFFFCC];

	public function new(width:Int, height:Int)
	{
		super();
		this.bitmapData = new BitmapData(width, height, true, 0x00000000);
	}

	public function drawItem(itemBitmap:BitmapData, dx:Int = 0, dy:Int = 0):Void
	{
		staticPoint.x = dx;
		staticPoint.y = dy;

		// First remove green.
		itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", 0xFF00FF00);
		// Copy pixels to main sheet.
		this.bitmapData.copyPixels(itemBitmap, this.bitmapData.rect, staticPoint, null, null, true);
		// Remove red AFTER overlay, trimming any pixles that are a pure red channel.
		this.bitmapData.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", 0xFFFF0000);
	}

	public static function colorItem(itemBitmap:BitmapData, colorNumber:Int, colorTypeNumber:Int, ?stripGreen:Bool = true,
			?transparency:Bool = true):BitmapData
	{
		if (stripGreen)
		{
			var bg:Int = (transparency) ? 0x0 : 0xFFFFFFFF;
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", 0xFF00FF00, bg);
		}

		// No color shift for item.
		if (colorNumber == 0)
		{
			return itemBitmap;
		}

		var replacementColor:ItemColor = avatarColors[colorNumber];

		// Skin.
		if (colorTypeNumber == 0)
		{
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", skinPalette[0], replacementColor.channel1);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", skinPalette[1], replacementColor.channel2);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", skinPalette[2], replacementColor.channel3);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", skinPalette[3], replacementColor.channel4);
		}

		// Hair.
		else if (colorTypeNumber == 1)
		{
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", hairPalette[0], replacementColor.channel1);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", hairPalette[1], replacementColor.channel2);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", hairPalette[2], replacementColor.channel3);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", hairPalette[3], replacementColor.channel4);
		}

		// Item.
		else if (colorTypeNumber == 2)
		{
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", greenPalette[0], replacementColor.channel1);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", greenPalette[1], replacementColor.channel2);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", greenPalette[2], replacementColor.channel3);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", greenPalette[3], replacementColor.channel4);

			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", bluePalette[0], replacementColor.channel1);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", bluePalette[1], replacementColor.channel2);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", bluePalette[2], replacementColor.channel3);
			itemBitmap.threshold(itemBitmap, itemBitmap.rect, zeroPoint, "==", bluePalette[3], replacementColor.channel4);
		}

		return itemBitmap;
	}

	public static function itemTypeToColorType(_itemType:String):Int
	{
		var colorType:Int = 0;

		switch (_itemType)
		{
			case GameItemType.BODY, GameItemType.FACE, GameItemType.SKIN:
				colorType = 0;
			case GameItemType.HAIR:
				colorType = 1;
			case GameItemType.DEFAULT_CLOTHING, GameItemType.SHOES, GameItemType.PANTS, GameItemType.SHIRT, GameItemType.HAT, GameItemType.GLASSES:
				colorType = 2;
		}

		return colorType;
	}
}
