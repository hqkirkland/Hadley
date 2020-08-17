package ui.windows.avatar;

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
class WieldBox extends WindowItem
{	
	public var gameItemBitmap:BitmapData;
	public var clothingType:String;
	public var validItemSet:Bool = false;
	
	public var itemListPrompt:ItemList;
	private var icon:BitmapData;
	public var itemList:ItemList;

	private static var iconRect:Rectangle = new Rectangle(0, 0, 17, 15);
	private static var iconPoint:Point = new Point(23, 23);
	
	public function new(?relativeX:Int, ?relativeY:Int, clothingItemType:String):Void
	{
		super(relativeX, relativeY, null);
		
		this.loadGraphic(Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_selected.png"), null, null, null, true);
		clothingType = clothingItemType;
		
		switch (clothingType)
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

		itemList = new ItemList(clothingType);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	override public function mousePressedHandler():Void
	{
		super.mousePressedHandler();
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