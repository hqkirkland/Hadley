package game.avatar;

import game.avatar.AvatarItem;
import game.items.GameItem;
import game.items.GameItemType;

/**
 * ...
 * @author Hunter
 */
class AvatarAppearance
{
	public var appearanceString(get, null):String;
	public var itemArray:Array<AvatarItem>;

	//public var pet:Pet;

	public function new(appearanceStr:String) 
	{
		itemArray = new Array<AvatarItem>();
		var figure:Array<String> = appearanceStr.split('^');

		for (n in 0...Std.int(figure.length / 2))
		{
			var gameItemKey:Int = Std.parseInt(figure[n * 2]);
			var colorKey:Int = Std.parseInt(figure[(n * 2) + 1]);

			wearItem(gameItemKey, colorKey);

			// Below shouldn't always need to exist.
		}
	}

	public function get_appearanceString():String
	{
		var appearanceStr:String = "";

		var n:Int = 0;

		for (_avatarItem in itemArray)
		{
			if (_avatarItem == null)
			{
				if (n != 4)
				{
					appearanceStr += "0^0";
				}

				// back of the hat is null. skip assembly.
				else
				{
					n++;
					continue;
				}
			}

			else
			{
				// skip assembling str of assets that are layered.
				if (_avatarItem.assetPath == _avatarItem.gameItem.layeredAsset)
				{
					//trace("Skipping " + _avatarItem.assetPath);
					continue;
				}

				appearanceStr += _avatarItem.gameItem.gameItemId + "^" + _avatarItem.itemColor;
			}
			
			if (n != (itemArray.length - 1))
			{
				appearanceStr += "^";
			}
			
			n++;
		}

		if (appearanceStr.charAt(appearanceStr.length - 1) == '^')
		{
			appearanceStr = appearanceStr.substr(0, appearanceStr.length - 1);
		}

		return appearanceStr;
	}

	public function getItemFromSlot(typeString:String):AvatarItem
	{
		return itemArray[GameItemType.typeToNum(typeString)];
	}

	public function wearItem(?gameItemId:Int=0, ?colorId:Int = 0):Void
	{
		if (gameItemId == 0 || !ClientData.clothingItems.exists(gameItemId))
		{
			return;
		}

		var _avatarItem:AvatarItem = {
			gameItem: ClientData.clothingItems[gameItemId],
			assetPath: Std.string(gameItemId),
			itemColor: colorId
		};

		if (isWearingItem(_avatarItem.gameItem) || !isSlotClear(_avatarItem.gameItem.itemType))
		{
			return;
		}

		Inventory.addWardrobeEntryById(_avatarItem.gameItem.gameItemId);

		var n:Int = GameItemType.typeToNum(_avatarItem.gameItem.itemType);
		itemArray[n] = _avatarItem;

		/*
		trace("AppearanceObj: Adding item #" + gameItemId + " @ slot #" + n);
		trace("Confirm: " + itemArray[n].gameItem.gameItemId + " added.");
		*/
		
		if (_avatarItem.gameItem.layered)
		{
			var layerItem:AvatarItem = {
				gameItem: ClientData.clothingItems[_avatarItem.gameItem.gameItemId],
				assetPath: ClientData.clothingItems[_avatarItem.gameItem.gameItemId].layeredAsset,
				itemColor: colorId
			};

			itemArray[4] = layerItem;
		}
	}

	public function clearItem(typeString:String)
	{
		var slot:Int = GameItemType.typeToNum(typeString);

		if (itemArray[slot] == null)
		{
			return;
		}

		if (itemArray[slot].gameItem.layered)
		{
			// Also gotta empty the hat!
			if (typeString == GameItemType.HAT)
			{
				itemArray[4] = null;
			}
		}

		if (slot != 0)
		{
			itemArray[slot] = null;
		}
	}

	public function colorItem(typeString:String, ?colorId:Int = 0)
	{
		var slot:Int = GameItemType.typeToNum(typeString);

		itemArray[slot].itemColor = colorId;

		if (itemArray[slot] == null)
		{
			return;
		}
	}

	public function isSlotClear(typeString:String)
	{
		return getItemFromSlot(typeString) == null;
	}
	
	public function isWearingItem(checkedItem:GameItem):Bool
	{
		var slot:Int = GameItemType.typeToNum(checkedItem.itemType);

		if (itemArray[slot] != null)
		{
			return itemArray[slot].gameItem.gameItemId == checkedItem.gameItemId;
		}

		return false;
	}
}