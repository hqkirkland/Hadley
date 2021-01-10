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
		}
	}

	public function get_appearanceString():String
	{
		var appearanceStr:String = "";

		var n:Int = 0;

		for (_avatarItem in itemArray)
		{
			var gameItemId:Int = 0;
			var colorId:Int = 0;
			
			if (_avatarItem == null)
			{
				// back of the hat can be null if not layered. skip assembly.
				if (n == 4)
				{
					n++;
					continue;
				}

				else
				{
					appearanceStr += gameItemId + "^" + colorId;

				}
			}

			else
			{
				var gameItemId:Int = 0;
				var colorId:Int = 0;

				gameItemId = _avatarItem.gameItem.gameItemId;
				colorId = _avatarItem.itemColor;

				// skip assembling str of assets that are layered.
				if (_avatarItem.assetPath == _avatarItem.gameItem.layeredAsset)
				{
					n++;
					continue;
				}

				appearanceStr += gameItemId + "^" + colorId;
			}
			
			if (n != itemArray.length - 1)
			{
				appearanceStr += "^";
				n++;
			}
		}

		if (appearanceStr.charAt(appearanceStr.length - 1) == '^')
		{
			trace("!!!! " + appearanceStr + " ends with extra ^");
			//appearanceStr = appearanceStr.substr(0, appearanceStr.length - 1);
		}

		return appearanceStr;
	}

	public function getItemFromSlot(typeString:String):AvatarItem
	{
		return itemArray[GameItemType.typeToNum(typeString)];
	}

	public function wearItem(?gameItemId:Int=0, ?colorId:Int = 0):Void
	{
		if (gameItemId == 0)
		{
			return;
		}

		var _avatarItem:AvatarItem;

		if (this == RoomState.playerAvatar.appearance)
		{
			trace("Setting appearance by Wardrobe");
			_avatarItem = Inventory.wardrobe[gameItemId];
		}

		else
		{
			_avatarItem = {
				gameItem: ClientData.clothingItems[gameItemId],
				assetPath: Std.string(gameItemId),
				itemColor: colorId
			};
		}

		if (isWearingItem(_avatarItem.gameItem) || !isSlotClear(_avatarItem.gameItem.itemType))
		{
			return;
		}

		var n:Int = GameItemType.typeToNum(_avatarItem.gameItem.itemType);
		itemArray[n] = _avatarItem;
		
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