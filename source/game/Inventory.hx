package game;

import game.items.GameItem;
import game.ClientData;

/**
 * ...
 * @author Hunter
 */
class Inventory
{
	// Owned items go into the wardrobe.
	public static var wardrobe:Array<GameItem> = new Array<GameItem>();
	// public static var furniture:Array<FurnitureItem>;
	
	public static function addItemById(itemId:Int):Void
	{
		if (ClientData.clothingItems.exists(itemId))
		{
			// Temp fix. Need better check?
			if (wardrobe.indexOf(ClientData.clothingItems[itemId]) == -1)
			{
				wardrobe.push(ClientData.clothingItems[itemId]);
			}
		}
	}
}