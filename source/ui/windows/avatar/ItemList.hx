package ui.windows.avatar;

import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import game.AvatarItem;
import game.ClothingItem;
import game.ClothingType;
import game.Inventory;
import openfl.Assets;
import openfl.display.BitmapData;
import ui.windows.WindowItem;
import ui.windows.avatar.SlotBox;

/**
 * ...
 * @author Hunter
 */
class ItemList extends WindowGroup
{
	public var listType:String;
	public var selectedItem:ClothingItem;
	public var slotBoxes:Array<SlotBox>;

	private var currentPage:Int = 0;
	private var currentSlot:Int = 0;
	private var itemSlotCursor:WindowItem;
	private var promptCloseButton:WindowItem;

	private static var itemsByType:Array<ClothingItem>;
	private static var itemGridContainer:BitmapData;
	private static var itemGridContainerX:BitmapData;
	private static var itemSlotInventory:BitmapData;
	private static var itemSlotSelected:BitmapData;

	public function new(clothingType:String, x:Int, y:Int, ?firstItem:Int = 0):Void
	{
		itemGridContainer = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_grid_container.png");
		itemGridContainerX = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_grid_container_x.png");
		itemSlotInventory = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_inventory.png");
		itemSlotSelected = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_selected.png");

		super("", itemGridContainer.width, itemGridContainer.height, x, y, false, itemGridContainer);
		listType = clothingType;

		itemsByType = Inventory.wardrobe.filter(matchClothingType);
		selectedItem = itemsByType[0];

		slotBoxes = new Array<SlotBox>();

		for (i in 0...9)
		{
			var slotX:Int = Std.int(this.mainWindow.x) + 5 + (((i % 3) * 30) + ((i % 3) * 10));
			var slotY:Int = Std.int(this.mainWindow.y) + 8 + ((Math.floor(i / 3) * 30) + (Math.floor(i / 3) * 10));

			slotBoxes.push(new SlotBox(listType, slotX, slotY));

			if (i < itemsByType.length)
			{
				slotBoxes[i].setGameItem(itemsByType[i].gameItemId, 2);
			}

			add(slotBoxes[i]);
		}

		itemSlotCursor = new WindowItem(Std.int(slotBoxes[0].windowPos.x), Std.int(slotBoxes[0].windowPos.y), itemSlotSelected);
		promptCloseButton = new WindowItem(120, 2, itemGridContainerX);
		promptCloseButton.mousePressedCallback = closeButtonClicked;

		add(itemSlotCursor);
		add(promptCloseButton);
	}

	private function closeButtonClicked(spr:FlxExtendedSprite, mouseX:Int, mouseY:Int)
	{
		this.visible = false;
	}

	public function resetList(clothingType:String)
	{
		remove(itemSlotCursor);

		listType = clothingType;
		itemsByType = Inventory.wardrobe.filter(matchClothingType);
		setPageItems();

		currentPage = 0;
		currentSlot = 0;
		selectedItem = slotBoxes[currentSlot].gameItem;

		itemSlotCursor = new WindowItem(Std.int(slotBoxes[currentSlot].windowPos.x), Std.int(slotBoxes[currentSlot].windowPos.y), itemSlotSelected);
		add(itemSlotCursor);
	}

	private function setPageItems():Void
	{
		for (i in 0...9)
		{
			var itemNum:Int = (currentPage * 9) + i;

			if (itemNum < itemsByType.length)
			{
				slotBoxes[i].setGameItem(itemsByType[itemNum].gameItemId, 3);
			}
			else
			{
				slotBoxes[i].clearGameItem();
			}
		}
	}

	public function nextPage():Void
	{
		currentPage++;
		setPageItems();
	}

	public function lastPage():Void
	{
		if (currentPage > 0)
		{
			currentPage--;
		}

		setPageItems();
	}

	public function matchClothingType(item:ClothingItem)
	{
		if (item != null && listType != null)
		{
			return (item.itemType == listType);
		}

		return false;
	}
}
