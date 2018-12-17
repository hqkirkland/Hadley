package game;

import flixel.FlxG;
import haxe.Json;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.utils.Object;

import openfl.net.URLLoader;
import openfl.net.URLRequest;

import game.ClothingItem;
import game.ItemColor;
/**
 * ...
 * @author Hunter
 */
 
class ClientData extends EventDispatcher
{
	public static var itemMap:Map<Int, ClothingItem>;
	
	private static var loader:URLLoader;
	
	public function start():Void
	{
		itemMap = new Map();
		
		var req:URLRequest = new URLRequest("http://dreamland.nodebay.com/gamedata/itemdata/all");
		
		loader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, itemFetchComplete);
		loader.load(req);
	}
	
	private function itemFetchComplete(e:Event)
	{
		var itemDataSet:Array<Array<Dynamic>> = Json.parse(loader.data);
		
		for (itemData in itemDataSet)
		{
			var item:ClothingItem = new ClothingItem(itemData[1]);
			item.gameItemId = itemData[0];
			item.itemName = itemData[2];
			item.itemDesc = itemData[3];
			item.layered = (itemData[4] == 1);
			
			if (item.layered)
			{
				item.layeredAsset = item.gameItemId + "b";
			}
			
			itemMap.set(item.gameItemId, item);
		}
		
		loader.removeEventListener(Event.COMPLETE, itemFetchComplete);
		
		var req:URLRequest = new URLRequest("http://dreamland.nodebay.com/gamedata/colors");
		loader = new URLLoader();
		loader.load(req);
		loader.addEventListener(Event.COMPLETE, finalize);
	}
	
	
	private function finalize(e:Event)
	{
		var colorDataSet:Array<ItemColor> = Json.parse(loader.data);
		
		for (colorData in colorDataSet)
		{
			GraphicsSheet.avatarColors.set(colorData.colorId, colorData);
		}
		
		this.dispatchEvent(new Event(Event.COMPLETE));
	}
}