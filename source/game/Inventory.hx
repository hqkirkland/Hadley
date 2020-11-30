package game;

import game.ClientData;
import game.ClothingItem;
import game.ItemColor;

/**
 * ...
 * @author Hunter
 */
class Inventory
{
	public static var wardrobe:Array<ClothingItem> = new Array<ClothingItem>();
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