package ui.windows.avatar;

import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedSprite;
import game.ClientData;
import game.GraphicsSheet;
import game.Inventory;
import game.items.GameItem;
import game.items.GameItemType;

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
	public var gameItem:GameItem;
	public var gameItemBitmap:BitmapData;
	
	public var slotId:Int;

	private static var itemSlotInventory:BitmapData;

	// dear day hunter,
	// closing avatar window
	// does not clear changes
	// to avatar.
	public function new(slotType:String, _slotId:Int, ?relativeX:Int, ?relativeY:Int):Void
	{
		super(relativeX, relativeY, null);

		slotId = _slotId;

		itemSlotInventory = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_inventory.png");
		this.loadGraphic(itemSlotInventory, false, 38, 38, true);

		clothingItemType = slotType;

		this.enableMouseClicks(true);
	}

	override public function mousePressedHandler():Void
	{
		super.mousePressedHandler();

		RoomState.starboard.avatarWindow.itemList.setSelectedItem(slotId);
	}

	public function clearGameItem():Void
	{
		gameItem = null;
		gameItemBitmap = null;
		clothingItemType = "";
		this.loadGraphic(itemSlotInventory, false, 38, 38, true);
	}

	public function setGameItem(gameItemKey:Int):Void
	{
		clearGameItem();

		if (ClientData.clothingItems.exists(gameItemKey))
		{
			gameItem = Inventory.wardrobe[gameItemKey].gameItem;
			clothingItemType = gameItem.itemType;
			var colorId:Int = Inventory.wardrobe[gameItemKey].itemColor;

			var itemBmp:BitmapData = Assets.getBitmapData("assets/items/icons/" + gameItemKey + ".png");
			gameItemBitmap = GraphicsSheet.colorItem(itemBmp, colorId, 2, true);

			this.pixels.copyPixels(gameItemBitmap, gameItemBitmap.rect, new Point(4, 4), null, null, false);
		}

		else
		{
			gameItem = null;

			var itemBmp:BitmapData = Assets.getBitmapData("starboard:assets/interface/starboard/elements/icons/what_the_duck.png");
			gameItemBitmap = GraphicsSheet.colorItem(itemBmp, 1, 2);

			this.pixels.copyPixels(gameItemBitmap, gameItemBitmap.rect, new Point(6, 6), null, null, false);
		}
	}
}
