package ui.windows.avatar;

import game.ClientData;
import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import game.Inventory;
import game.avatar.AvatarItem;
import game.items.GameItem;
import game.items.GameItemType;
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
	public var selectedItem:Int;
	public var slotBoxes:Array<SlotBox>;

	private var currentPage:Int = 0;
	private var currentSlot:Int = 0;
	private var itemSlotCursor:WindowItem;
	private var promptCloseButton:WindowItem;

	private static var itemsByType:Array<AvatarItem>;
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

		itemsByType = new Array<AvatarItem>();

		for (gameItemId in Inventory.wardrobe.keys())
		{
			trace ("Inventory: " + gameItemId);
			var _avatarItem:AvatarItem = Inventory.wardrobe[gameItemId];

			if (_avatarItem.gameItem.itemType == listType)
			{
				itemsByType.push(_avatarItem);
				trace("Adding: " + _avatarItem.gameItem);
			}
		}

		slotBoxes = new Array<SlotBox>();

		for (i in 0...9)
		{
			var slotX:Int = Std.int(this.mainWindow.x) + 5 + (((i % 3) * 30) + ((i % 3) * 10));
			var slotY:Int = Std.int(this.mainWindow.y) + 8 + ((Math.floor(i / 3) * 30) + (Math.floor(i / 3) * 10));

			slotBoxes.push(new SlotBox(listType, i, slotX, slotY));

			if (i < itemsByType.length)
			{
				if (itemsByType[i] != null)
				{
					slotBoxes[i].setGameItem(itemsByType[i].gameItem.gameItemId);
				}
			}

			add(slotBoxes[i]);
		}

		if (slotBoxes[currentSlot].gameItem != null)
		{
			selectedItem = itemsByType[currentSlot].gameItem.gameItemId;
		}

		itemSlotCursor = new WindowItem(Std.int(slotBoxes[0].windowPos.x), Std.int(slotBoxes[0].windowPos.y), itemSlotSelected);
		promptCloseButton = new WindowItem(120, 2, itemGridContainerX);
		promptCloseButton.mousePressedCallback = closeButtonClicked;

		add(itemSlotCursor);
		add(promptCloseButton);
	}

	public function resetList(clothingType:String):Void
	{
		remove(itemSlotCursor);

		listType = clothingType;

		RoomState.starboard.avatarWindow.colorList.resetList(clothingType);

		itemsByType = new Array<AvatarItem>();

		for (gameItemId in Inventory.wardrobe.keys())
		{
			var _avatarItem:AvatarItem = Inventory.wardrobe[gameItemId];

			if (_avatarItem.gameItem.itemType == listType)
			{
				itemsByType.push(_avatarItem);
			}
		}

		setPageItems();

		currentPage = 0;
		currentSlot = 0;

		if (slotBoxes[currentSlot].gameItem != null)
		{
			selectedItem = slotBoxes[currentSlot].gameItem.gameItemId;
		}

		itemSlotCursor = new WindowItem(Std.int(slotBoxes[currentSlot].windowPos.x), Std.int(slotBoxes[currentSlot].windowPos.y), itemSlotSelected);
		add(itemSlotCursor);
	}

	public function setSelectedItem(_slotId:Int)
	{
		currentSlot = _slotId;

		if (slotBoxes[currentSlot].gameItem == null)
		{
			selectedItem = 0;
			AvatarWindow.playerPreview.clearItem(listType);
		}
		
		else
		{
			selectedItem = slotBoxes[currentSlot].gameItem.gameItemId;
			AvatarWindow.playerPreview.wearItem(selectedItem);
		}

		RoomState.starboard.avatarWindow.updateWieldedItems();

		itemSlotCursor.windowPos.set(slotBoxes[currentSlot].windowPos.x, slotBoxes[currentSlot].windowPos.y);
	}

	public function changeItemColor(colorId:Int):Void
	{
		if (slotBoxes[currentSlot].gameItem != null)
		{
			Inventory.wardrobe[slotBoxes[currentSlot].gameItem.gameItemId].itemColor = colorId;
			trace(Inventory.wardrobe[slotBoxes[currentSlot].gameItem.gameItemId].itemColor);
			AvatarWindow.playerPreview.colorItem(listType, colorId);
			slotBoxes[currentSlot].setGameItem(slotBoxes[currentSlot].gameItem.gameItemId);
		}

		RoomState.starboard.avatarWindow.updateWieldedItems();
	}

	private function closeButtonClicked(spr:FlxExtendedSprite, mouseX:Int, mouseY:Int)
	{
		this.visible = false;
	}

	private function setPageItems():Void
	{
		for (i in 0...9)
		{
			var itemNum:Int = (currentPage * 9) + i;

			if (itemsByType[itemNum] == null)
			{
				continue;
			}

			if (itemNum < itemsByType.length)
			{
				trace(i + "/" + itemsByType.length);
				slotBoxes[i].setGameItem(itemsByType[itemNum].gameItem.gameItemId);
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

	public function matchItemType(_avatarItem:AvatarItem)
	{
		if (_avatarItem != null && listType != null)
		{
			return (_avatarItem.gameItem.itemType == listType);
		}

		return false;
	}
}
