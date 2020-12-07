package game;

import haxe.Json;

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
	//public static var pets:Map<Int, Pet>;
	//public static var 
	
	private static var loader:URLLoader;
	private static var apiClient:ApiClient = new ApiClient();
	
	public function start():Void
	{
		clothingItems = new Map();
		
		apiClient.fetchItemdata();
		apiClient.addEventListener(ApiEvent.ITEMDATA, itemFetchComplete);
	}
	
	private function itemFetchComplete(apiEvent:ApiEvent):Void
	{
		var itemDataSet:Array<Array<Dynamic>> = Json.parse(apiEvent.result);
		
		for (itemData in itemDataSet)
		{
			switch (itemData[1])
			{
				case GameItemType.DEFAULT_CLOTHING, GameItemType.HAIR, GameItemType.SHOES, GameItemType.PANTS, GameItemType.SHIRT, GameItemType.HAT, GameItemType.GLASSES, GameItemType.FACE, GameItemType.BODY:
					pushClothingItem(itemData);
			}
		}
		
		apiClient.removeEventListener(ApiEvent.ITEMDATA, itemFetchComplete);
		
		var req:URLRequest = new URLRequest(Endpoints.COLORDATA);
		loader = new URLLoader();
		loader.load(req);
		loader.addEventListener(Event.COMPLETE, colorFetchComplete);
	}
	
	private function pushClothingItem(itemData:Array<Dynamic>):Void
	{
		var item:GameItem = new GameItem(itemData[1]);
		item.gameItemId = itemData[0];
		item.itemName = itemData[2];
		item.itemDesc = itemData[3];
		item.layered = (itemData[4] == 1);
		
		if (item.layered)
		{
			item.layeredAsset = item.gameItemId + "b";
		}
		
		clothingItems.set(item.gameItemId, item);
	}
	
	private function colorFetchComplete(e:Event)
	{
		var colorDataSet:Array<ItemColor> = Json.parse(loader.data);
		
		for (colorData in colorDataSet)
		{
			GraphicsSheet.avatarColors.set(colorData.colorId, colorData);
		}
		
		this.dispatchEvent(new Event(Event.COMPLETE));
	}
}