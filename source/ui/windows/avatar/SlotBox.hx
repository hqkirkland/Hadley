package ui.windows.avatar;

import flixel.addons.display.FlxExtendedSprite;
import game.ClientData;
import game.ClothingItem;
import game.ClothingType;
import game.GraphicsSheet;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import ui.windows.WindowItem;

/**
 * ...
 * @author Hunter
 */
class SlotBox extends WindowItem
{
	public var clothingItemType:String;
	public var gameItem:ClothingItem;
	public var gameItemBitmap:BitmapData;

	private var icon:BitmapData;

	// dear day hunter,
	// closing avatar window
	// does not clear changes
	// to avatar.
	public function new(slotType:String, ?relativeX:Int, ?relativeY:Int):Void
	{
		super(relativeX, relativeY, null);
		this.loadGraphic(Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_inventory.png"), false, 0, 0, true);
		clothingItemType = slotType;
	}

	override public function mousePressedHandler():Void
	{
		super.mousePressedHandler();
	}

	public function clearGameItem():Void
	{
		gameItem = null;

		var itemBmp:BitmapData = new BitmapData(30, 30, false, 0x00000000);
		this.pixels.copyPixels(itemBmp, itemBmp.rect, new Point(4, 4), null, null, true);
	}

	public function setGameItem(gameItemKey:Int, colorId:Int, ?clearFirst:Bool = true):Void
	{
		if (clearFirst)
		{
			clearGameItem();
		}

		if (ClientData.clothingItems.exists(gameItemKey))
		{
			gameItem = ClientData.clothingItems[gameItemKey];
			gameItem.itemType = clothingItemType;

			var itemBmp:BitmapData = Assets.getBitmapData("assets/items/icons/" + gameItemKey + ".png");
			gameItemBitmap = GraphicsSheet.colorItem(itemBmp, colorId, 2, true);

			this.pixels.copyPixels(gameItemBitmap, gameItemBitmap.rect, new Point(4, 4), null, null);
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
