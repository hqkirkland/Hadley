package game;

import game.ClientData;

import game.avatar.AvatarItem;

/**
 * ...
 * @author Hunter
 */
class Inventory
{
	// Owned items go into the wardrobe.
	public static var wardrobe:Map<Int, AvatarItem> = new Map<Int, AvatarItem>();
	// public static var furniture:Array<FurnitureItem>;
	
	public static function addWardrobeItemById(gameItemId:Int, colorId:Int):Void
	{
		if (hasWardrobeItem(gameItemId))
		{
			return;
		}

		var _avatarItem:AvatarItem = {
			gameItem: ClientData.clothingItems[gameItemId],
			assetPath: Std.string(gameItemId),
			itemColor: colorId
		};

		wardrobe.set(gameItemId, _avatarItem);
	}

	public static function hasWardrobeItem(gameItemId:Int):Bool
	{
		return wardrobe.exists(gameItemId);
	}
}