package ui;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;

import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;

import game.ClientData;
import game.GraphicsSheet;

/**
 * ...
 * @author Hunter
 */
class SlotBox extends FlxExtendedSprite
{	
	public var gameItemBitmap:BitmapData;
	public var validItemSet:Bool = false;
	
	// Relative positions.
	public var posX:Float;
	public var posY:Float;
	
	public function new(?x:Float, ?y:Float):Void
	{
		super(x, y, Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_grid.png"));
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	public function lockPosition(relativeX:Float, relativeY:Float):Void
	{
		posX = relativeX;
		posY = relativeY;
	}
	
	public function setGameItem(gameItemKey:Int, colorId:Int):Void
	{
		//var itemBmp:BitmapData = Assets.getBitmapData("assets/items/icons/" + gameItemKey + ".png");
		
		if (ClientData.clothingItems.exists(gameItemKey))
		{
			validItemSet = true;
			
			var itemBmp:BitmapData = Assets.getBitmapData("assets/items/icons/" + gameItemKey + ".png");
			gameItemBitmap = GraphicsSheet.colorItem(itemBmp, colorId, 2, true);
			
			this.pixels.copyPixels(gameItemBitmap, gameItemBitmap.rect, new Point(4, 4), null, null, true);
		}
		
		else
		{
			var itemBmp:BitmapData = Assets.getBitmapData("starboard:assets/interface/starboard/elements/icons/what_the_duck.png");
			gameItemBitmap = GraphicsSheet.colorItem(itemBmp, colorId, 2);
			
			this.pixels.copyPixels(gameItemBitmap, gameItemBitmap.rect, new Point(6, 6), null, null, true);
		}
		
	}
}