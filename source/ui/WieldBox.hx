package ui;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

import flixel.addons.display.FlxExtendedSprite;

import game.ClientData;
import game.ClothingType;
import game.GraphicsSheet;

/**
 * ...
 * @author Hunter
 */
class WieldBox extends FlxExtendedSprite
{	
	public var gameItemBitmap:BitmapData;
	public var validItemSet:Bool = false;
	
	// Relative positions.
	public var posX:Float;
	public var posY:Float;
	
	private var icon:BitmapData;
	
	private static var iconRect:Rectangle = new Rectangle(0, 0, 17, 15);
	private static var iconPoint:Point = new Point(23, 23);
	
	public function new(clothingItemType:String, ?x:Float, ?y:Float):Void
	{
		super(x, y, Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_selected.png"));		
		
		switch (clothingItemType)
		{
			case ClothingType.HAT:
				icon = Assets.getBitmapData("starboard:assets/interface/starboard/elements/icons/hat_slot_icon.png");
			case ClothingType.GLASSES:
				icon = Assets.getBitmapData("starboard:assets/interface/starboard/elements/icons/glasses_slot_icon.png");
			case ClothingType.SHIRT:
				icon = Assets.getBitmapData("starboard:assets/interface/starboard/elements/icons/shirt_slot_icon.png");
			case ClothingType.PANTS:
				icon = Assets.getBitmapData("starboard:assets/interface/starboard/elements/icons/pants_slot_icon.png");
			case ClothingType.SHOES:
				icon = Assets.getBitmapData("starboard:assets/interface/starboard/elements/icons/shoes_slot_icon.png");
			default:
				icon = new BitmapData(17, 15, true, 0x00000000);
		}
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
		validItemSet = true;
		
		var itemBmp:BitmapData = new BitmapData(30, 30, false, 0x00000000);
		this.pixels.copyPixels(itemBmp, itemBmp.rect, new Point(4, 4), null, null, true);
	}
	
	public function setGameItem(gameItemKey:Int, colorId:Int):Void
	{
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
		
		this.pixels.copyPixels(icon, iconRect, iconPoint, null, null, true);
	}
}