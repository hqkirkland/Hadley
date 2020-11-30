package ui.windows.avatar;

import communication.NetworkManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.debug.FlxDebugger;
import game.ClothingItem;
import game.ClothingType;

/**
 * ...
 * @author Hunter
**/
class AvatarWindow extends WindowGroup
{
	public var itemList:ItemList;

	public static var playerPreview:AvatarPreview;

	private static var avatarContainer:WindowItem;
	private static var hatSlotBox:WieldBox;
	private static var glassesSlotBox:WieldBox;
	private static var shirtSlotBox:WieldBox;
	private static var pantsSlotBox:WieldBox;
	private static var shoesSlotBox:WieldBox;
	private static var changeButton:WindowButton;
	private static var colorPicker:ColorList;

	public function new():Void
	{
		super("Avatar", 250, 200, 0, 0);

		hatSlotBox = new WieldBox(Math.ceil(this.width) - 20 - 38, 40, ClothingType.HAT);
		shirtSlotBox = new WieldBox(Math.ceil(this.width) - 20 - 38, 90, ClothingType.SHIRT);
		pantsSlotBox = new WieldBox(Math.ceil(this.width) - 20 - 38, 140, ClothingType.PANTS);
		glassesSlotBox = new WieldBox(20, 40, ClothingType.GLASSES);
		shoesSlotBox = new WieldBox(20, 140, ClothingType.SHOES);

		playerPreview = new AvatarPreview(RoomState.playerAvatar.appearanceString, 105, 68);

		changeButton = new WindowButton(2, "starboard:assets/interface/starboard/elements/buttons/change_look.png", true);
		changeButton.setAnimation("", [0], false, false);
		changeButton.setAnimation("clicked", [1], false, true);
		changeButton.windowPos.set((this.width / 2)- (changeButton.width / 2), this.height - 28);

		setWieldedItems();

		add(hatSlotBox);
		add(shirtSlotBox);
		add(pantsSlotBox);
		add(glassesSlotBox);
		add(shoesSlotBox);

		add(changeButton);

		add(playerPreview);
		
	}

	public function updateItemList(itemListType:String)
	{
		if (itemList == null)
		{
			itemList = new ItemList(itemListType, 0, 0, 0);
		}
		else
		{
			itemList.visible = true;
			if (itemListType != itemList.listType)
			{
				itemList.resetList(itemListType);
				trace("Resetting itemList. itemList at: " + this.itemList.x + ", " + this.itemList.y);
				trace("Resetting itemList. Main window at: " + this.mainWindow.x + ", " + this.mainWindow.y);
				// .windowSystem
				StarboardInterface.windowSystem.remove(itemList);
			}
		}

		if (itemList.listType == ClothingType.GLASSES || itemList.listType == ClothingType.SHOES)
		{
			itemList.x = this.mainWindow.x - itemList.width - 5;
			itemList.y = this.mainWindow.y + Std.int(this.height / 2) - Std.int(itemList.height / 2);
		}
		else
		{
			itemList.x = this.mainWindow.x + this.mainWindow.width + 5;
			itemList.y = this.mainWindow.y + Std.int(this.mainWindow.height / 2) - Std.int(itemList.height / 2);
		}

		StarboardInterface.windowSystem.add(itemList);
		trace("itemList Reset! itemList at: " + this.itemList.x + ", " + this.itemList.y);
		trace("itemList Reset! Main window at: " + this.mainWindow.x + ", " + this.mainWindow.y);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (changeButton.isPressed)
		{
			var appearanceStr:String = playerPreview.appearance.appearanceString;

			trace(appearanceStr);

			RoomState.playerAvatar.setAppearance(appearanceStr);
			RoomState.starboard.changeAppearance(appearanceStr);
			NetworkManager.sendChangeClothes(appearanceStr);
		}
	}

	public function updateWieldedItems()
	{
		// TODO: add item-type specific update.
		setWieldedItems();
	}

	private function setWieldedItems()
	{
		var itemIndex:Int = 0;

		for (item in RoomState.playerAvatar.appearance.itemArray)
		{
			// Skip null items, and the fourth item.
			// itemArray is the actual figure of the Avatar.
			// The fourth item is the back of the hat, if it is two-halved.
			// Like Monk's hat is.

			if (item == null || itemIndex == 4)
			{
				itemIndex++;
				continue;
			}

			switch (item.gameItem.itemType)
			{
				case ClothingType.GLASSES:
					glassesSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
				case ClothingType.SHIRT:
					shirtSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
				case ClothingType.PANTS:
					pantsSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
				case ClothingType.SHOES:
					shoesSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
				case ClothingType.HAT:
					hatSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
			}

			itemIndex++;
		}
	}
}
