package ui.windows.avatar;

import flixel.addons.display.FlxExtendedSprite;
import game.ClientData;
import game.ClothingType;
import game.GraphicsSheet;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Hunter
 */
class WieldBox extends WindowItem
{
	public var clothingType:String;
	public var validItemSet:Bool = false;

	private var gameItemBitmap:BitmapData;
	private var icon:BitmapData;

	private static var iconRect:Rectangle = new Rectangle(0, 0, 17, 15);
	private static var iconPoint:Point = new Point(23, 23);

	private static var itemSlotInventory:BitmapData;
	private static var itemSlotSelected:BitmapData;

	public function new(?relativeX:Int, ?relativeY:Int, clothingItemType:String):Void
	{
		super(relativeX, relativeY, null);

		itemSlotInventory = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_inventory.png");
		this.loadGraphic(itemSlotInventory, false, itemSlotInventory.width, itemSlotInventory.height, true);

		itemSlotSelected = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_selected.png");
		this.pixels.copyPixels(itemSlotSelected, itemSlotSelected.rect, new Point(0, 0), null, null, false);

		clothingType = clothingItemType;
		this.enableMouseClicks(true);

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
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	override public function mousePressedHandler():Void
	{
		// Animation?
		super.mousePressedHandler();
		RoomState.starboard.avatarWindow.updateItemList(this.clothingType);
	}

	public function setGameItem(gameItemKey:Int, colorId:Int):Void
	{
		this.pixels.copyPixels(itemSlotInventory, itemSlotInventory.rect, new Point(0, 0), null, null, false);
		this.pixels.copyPixels(itemSlotSelected, itemSlotSelected.rect, new Point(0, 0), null, null, false);

		if (ClientData.clothingItems.exists(gameItemKey))
		{
			validItemSet = true;

			gameItemBitmap = GraphicsSheet.colorItem(Assets.getBitmapData("assets/items/icons/" + gameItemKey + ".png", false), colorId, 2, true);

			this.pixels.copyPixels(gameItemBitmap, gameItemBitmap.rect, new Point(4, 4), null, null, false);
		}
		else
		{
			gameItemBitmap = GraphicsSheet.colorItem(Assets.getBitmapData("starboard:assets/interface/starboard/elements/icons/what_the_duck.png"), colorId,
				2);

			this.pixels.copyPixels(gameItemBitmap, gameItemBitmap.rect, new Point(6, 6), null, null, true);
		}

		this.pixels.copyPixels(icon, iconRect, iconPoint, null, null, true);
	}
}
