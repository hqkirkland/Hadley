package ui;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

import flixel.addons.display.FlxExtendedSprite;

import game.ClothingItem;
import game.ClientData;
import game.ClothingType;
import game.GraphicsSheet;

/**
 * ...
 * @author Hunter
 */
class SlotBox extends FlxExtendedSprite
{
	public var clothingItemType:String;
	public var gameItem:ClothingItem;
	public var gameItemBitmap:BitmapData;
	public var validItemSet:Bool = false;
	
	// Relative positions.
	public var posX:Float;
	public var posY:Float;
	
	private var icon:BitmapData;
	// dear day hunter, 
	// closing avatar window 
	// does not clear changes 
	// to avatar.
	public function new(slotType:String, ?x:Float, ?y:Float):Void
	{
		super(x, y);
		this.loadGraphic(Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_inventory.png"), null, null, null, true);
		clothingItemType = slotType;
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
	
	public function clearGameItem():Void
	{
		gameItem = null;
		validItemSet = true;
		
		var itemBmp:BitmapData = new BitmapData(30, 30, false, 0x00000000);
		this.pixels.copyPixels(itemBmp, itemBmp.rect, new Point(4, 4), null, null, true);
	}
	
	public function swapGameItem(gameItemKey:Int, colorId:Int):ClothingItem
	{
		var oldGameItem:ClothingItem = gameItem;
		setGameItem(gameItemKey, colorId);
		
		return oldGameItem;
	}
	
	public function setGameItem(gameItemKey:Int, colorId:Int):Void
	{
		if (ClientData.clothingItems.exists(gameItemKey))
		{
			gameItem = ClientData.clothingItems[gameItemKey];
			
			validItemSet = true;
			
			var itemBmp:BitmapData = Assets.getBitmapData("assets/items/icons/" + gameItemKey + ".png");
			gameItemBitmap = GraphicsSheet.colorItem(itemBmp, colorId, 2, true);
			
			this.pixels.copyPixels(gameItemBitmap, gameItemBitmap.rect, new Point(4, 4), null, null, true);
		}
		
		else
		{
			gameItem = null;
			
			var itemBmp:BitmapData = Assets.getBitmapData("starboard:assets/interface/starboard/elements/icons/what_the_duck.png");
			gameItemBitmap = GraphicsSheet.colorItem(itemBmp, colorId, 2);
			
			this.pixels.copyPixels(gameItemBitmap, gameItemBitmap.rect, new Point(6, 6), null, null, true);
		}
	}
}