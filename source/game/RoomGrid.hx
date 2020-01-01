package game;
import flixel.FlxSprite;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.geom.Point;

/**
 * ...
 * @author ...
 */
class RoomGrid
{
	
	private static inline var TILE_WIDTH:Int = 27;
	private static inline var TILE_HEIGHT:Int = 9;

	private static inline var X_PIXEL_SLOPE:Int = 3;
	private static inline var Y_PIXEL_SLOPE:Int = 1;
	
	private static var tileRect:Rectangle = new Rectangle(0, 0, 27, 9);
	
	public var rawMap:Array<Array<Int>> = 
	[
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1]
	];

	public var mapBmp:BitmapData;
	
	private var walkMapX:Int;
	private var walkMapY:Int;
	private var copyPoint:Point = new Point(0, 0);
	private var tileBmp:BitmapData = Assets.getBitmapData("assets/core/tile.png", true);
	
	public function new(_walkMapX:Int, _walkMapY:Int) 
	{
		walkMapX = _walkMapX;
		walkMapY = _walkMapY;
		
		var maxX:Int = rawMap[0].length;
		var maxY:Int = rawMap.length;
		
		var zeroTileBmpX:Int = ( Math.ceil(( (TILE_WIDTH - X_PIXEL_SLOPE) * maxX) / 2) - Math.ceil((TILE_WIDTH / 2)) );
		
		mapBmp = new BitmapData(((TILE_WIDTH - X_PIXEL_SLOPE) * maxY), (TILE_HEIGHT - Y_PIXEL_SLOPE) * maxX, true, 0x0);
		
		for (rowNum in 0...maxY)
		{
			for (tileNum in 0...maxX)
			{
				if (rawMap[rowNum][tileNum] == 0)
				{
					continue;
				}
				
				copyPoint.x = (zeroTileBmpX - (rowNum *  Math.ceil( (TILE_WIDTH - X_PIXEL_SLOPE) / 2 ) )) + (tileNum * Math.ceil( (TILE_WIDTH - X_PIXEL_SLOPE) / 2 ));
				copyPoint.y = (rowNum *  Math.ceil( (TILE_HEIGHT - Y_PIXEL_SLOPE) / 2 )) + (tileNum *  Math.ceil((TILE_HEIGHT - Y_PIXEL_SLOPE) / 2)) + 1;
				mapBmp.copyPixels(tileBmp, tileRect, copyPoint);
			}
		}
	} 
}