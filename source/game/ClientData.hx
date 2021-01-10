package game;

import haxe.Json;
import haxe.DynamicAccess;

import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.net.URLLoader;
import openfl.net.URLRequest;

import communication.api.ApiClient;
import communication.api.Endpoints;
import communication.api.events.ApiEvent;

import game.items.GameItem;
import game.items.GameItemType;
import game.items.ItemColor;
/**
 * ...
 * @author Hunter
 */
 
class ClientData extends EventDispatcher
{
	public static var clothingItems:Map<Int, GameItem>;
	//public static var pets:Map<Int, Pet>; // <- A pet is either active or inactive, depending on if it is in the "egg" state or not.
	//public static var petItems:Map<Int, GameItem>;
	//public static var equipment:Map<Int, GameItem>;
	//public static var 
	
	private static var loader:URLLoader;
	private static var apiClient:ApiClient = new ApiClient();
	
	public function start():Void
	{
		clothingItems = new Map();
		
		apiClient.addEventListener(ApiEvent.ITEMDATA, itemFetchComplete);
		apiClient.fetchItemdata();
	}
	
	private function itemFetchComplete(apiEvent:ApiEvent):Void
	{
		var itemDataSet:Array<DynamicAccess<Dynamic>> = Json.parse(apiEvent.result);
		
		for (itemData in itemDataSet)
		{
			//trace(itemData);
			switch (itemData["itemType"])
			{
				case GameItemType.DEFAULT_CLOTHING, 
				GameItemType.HAIR, 
				GameItemType.SHOES, 
				GameItemType.PANTS, 
				GameItemType.SHIRT, 
				GameItemType.HAT, 
				GameItemType.GLASSES, 
				GameItemType.FACE, 
				GameItemType.BODY:
					pushClothingItem(itemData);
			}
		}
		
		apiClient.removeEventListener(ApiEvent.ITEMDATA, itemFetchComplete);
		apiClient.fetchColordata();

		apiClient.addEventListener(ApiEvent.COLORDATA, colorFetchComplete);
	}
	
	private function pushClothingItem(itemData:DynamicAccess<Dynamic>):Void
	{
		var item:GameItem = new GameItem(itemData["itemType"]);
		item.gameItemId = itemData.get("gameItemId");
		item.itemName = itemData["itemName"];
		item.itemDesc = itemData["itemDesc"];
		item.layered = (itemData["layered"]) == 1;
		
		if (item.layered)
		{
			item.layeredAsset = item.gameItemId + "b";
		}
		
		clothingItems.set(item.gameItemId, item);
	}
	
	private function colorFetchComplete(apiEvent:ApiEvent)
	{
		var colorDataSet:Array<ItemColor> = Json.parse(apiEvent.result);
		
		for (colorData in colorDataSet)
		{
			GraphicsSheet.itemColors.set(colorData.colorId, colorData);
		}
		
		apiClient.removeEventListener(ApiEvent.COLORDATA, colorFetchComplete);
		apiClient.fetchInventory();

		apiClient.addEventListener(ApiEvent.INVENTORY, inventoryFetchComplete);

	}

	private function inventoryFetchComplete(apiEvent:ApiEvent)
	{
		trace("Inventory fetch complete.");

		var inventorySet:Array<DynamicAccess<Dynamic>> = Json.parse(apiEvent.result);

		for (inventoryItem in inventorySet)
		{
			Inventory.addWardrobeItemById(inventoryItem["gameItemId"], inventoryItem["colorId"]);
		}
		
		// Event.COMPLETE signals the beginning of the connection.
		this.dispatchEvent(new Event(Event.COMPLETE));
		apiClient.removeEventListener(ApiEvent.INVENTORY, inventoryFetchComplete);
	}
}