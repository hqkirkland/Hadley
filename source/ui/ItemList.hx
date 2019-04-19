package ui;

import openfl.Assets;
import openfl.display.BitmapData;

import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup;

import game.ClothingItem;
import game.ClothingType;
import game.MasterInventory;
import ui.SlotBox;

/**
 * ...
 * @author Hunter
 */
class ItemList extends FlxSpriteGroup
{
	public var listType:String;
	public var selectedItem:ClothingItem;
	public var slotBoxes:Array<SlotBox>;
	public var itemsByType:Array<ClothingItem>;
	
	public var posX:Float;
	public var posY:Float;
	
	private var currentPage:Int = 0;
	private var currentSlot:Int = 0;

	private static var itemGridContainer:BitmapData;
	private static var itemSlotInventory:BitmapData;
	private static var itemSlotSelected:BitmapData;
	
	private static var itemSlotCursor:FlxSprite;
	
	public function new(itemType:String, ?firstItem:Int=0, ?x:Float, ?y:Float):Void
	{
		super(x, y);
		
		// Use first item to scan for 
		
		itemGridContainer = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_grid_container.png");
		itemSlotInventory = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_inventory.png");
		itemSlotSelected = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_selected.png");
		
		listType = itemType;
		itemsByType = MasterInventory.wardrobe.filter(matchClothingType);
		
		slotBoxes = new Array<SlotBox>();
		
		add(new FlxSprite(0, 0, itemGridContainer));

		for (i in 0...9)
		{
			var slotX:Int = 5 + (((i % 3) * 30) + ((i % 3) * 10));
			var slotY:Int = 8 + ((Math.floor(i / 3) * 30) + (Math.floor(i / 3) * 10));
			
			slotBoxes.push(new SlotBox(listType, slotX, slotY));
			
			if (i < itemsByType.length)
			{
				slotBoxes[i].setGameItem(itemsByType[i].gameItemId, 0);
			}
			
			add(slotBoxes[i]);
		}
		
		itemSlotCursor = new FlxSprite();
		itemSlotCursor.loadGraphic(itemSlotSelected);
		add(itemSlotCursor);
		itemSlotCursor.x = slotBoxes[0].x;
		itemSlotCursor.y = slotBoxes[0].y;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		for (i in 0...9)
		{
			if (slotBoxes[i].isPressed)
			{
				currentSlot = i;
				
				add(itemSlotCursor);
				itemSlotCursor.x = slotBoxes[i].x;
				itemSlotCursor.y = slotBoxes[i].y;
					
				if (slotBoxes[i].gameItem != selectedItem)
				{
					selectedItem = slotBoxes[i].gameItem;
				}
				
				break;
			}
		}
	}
	
	public function lockPosition(relativeX:Float, relativeY:Float):Void
	{
		posX = relativeX;
		posY = relativeY;
	}
	
	private function setPageItems():Void
	{
		for (i in 0...9)
		{
			var itemNum:Int = (currentPage * 9) + i;
			
			if (itemNum <= itemsByType.length)
			{
				slotBoxes[i].setGameItem(itemsByType[itemNum].gameItemId, 3);
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
	
	public function buildPage():Void
	{
	
	}
	
	public function matchClothingType(item:ClothingItem)
	{
		return (item.itemType == listType);
	}
}