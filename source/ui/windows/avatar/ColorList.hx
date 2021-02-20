package ui.windows.avatar;

import flixel.math.FlxPoint;
import openfl.Assets;
import openfl.display.BitmapData;


import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import game.ClientData;
import game.GraphicsSheet;
import game.Inventory;
import game.avatar.AvatarItem;
import game.items.ItemColor;
import game.items.GameItem;
import game.items.GameItemType;

import ui.windows.WindowItem;
import ui.windows.avatar.SlotBox;

/**
 * ...
 * @author Hunter
 */
class ColorList extends WindowGroup
{
	public var listType:Int;
	public var selectedColor:ItemColor;
	public var colorBoxes:Array<ColorBox>;
	public var colorSet:Array<ItemColor>;

	private var currentPage:Int = 0;
	private var currentSlot:Int = 0;
	private var itemSlotCursor:WindowItem;
	private var promptCloseButton:WindowItem;

	private static var itemsByType:Array<AvatarItem>;
	private static var itemGridContainer:BitmapData;
	private static var itemGridContainerX:BitmapData;
	private static var itemSlotInventory:BitmapData;
	private static var itemSlotSelected:BitmapData;

	public function new(clothingType:String, x:Int, y:Int, ?firstItem:Int = 0):Void
	{
		itemGridContainer = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_grid_container.png");
		itemGridContainerX = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_grid_container_x.png");
		itemSlotInventory = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_inventory.png");
		itemSlotSelected = Assets.getBitmapData("starboard:assets/interface/starboard/elements/item_slot_selected.png");

		super("", itemGridContainer.width, itemGridContainer.height, x, y, false, itemGridContainer);
		
		listType = GraphicsSheet.itemTypeToColorType(clothingType);
		colorSet = new Array<ItemColor>();
		
		for (colorId in GraphicsSheet.itemColors.keys())
		{	
			if (listType == GraphicsSheet.itemTypeToColorType(GraphicsSheet.itemColors[colorId].itemType))
			{
				colorSet.push(GraphicsSheet.itemColors[colorId]);
			}
		}
		
		currentSlot = 0;
		selectedColor = colorSet[0];
		colorBoxes = new Array<ColorBox>();
		
		var i:Int = 0;
		for (color in colorSet)
		{
			var colorBox:ColorBox = new ColorBox(14 + ((i % 6) * 1) + ((i % 6) * 16), 9 + (Math.floor(i / 6) * 1) + (Math.floor(i / 6) * 16), color);
			
			colorBoxes.push(colorBox);
			add(colorBoxes[i]);
			i++;
		}

		//itemSlotCursor = new WindowItem(Std.int(slotBoxes[0].windowPos.x), Std.int(slotBoxes[0].windowPos.y), itemSlotSelected);
		promptCloseButton = new WindowItem(120, 2, itemGridContainerX);
		promptCloseButton.mousePressedCallback = closeButtonClicked;

		add(promptCloseButton);
	}

	public function resetList(clothingType:String)
	{
		listType = GraphicsSheet.itemTypeToColorType(clothingType);
		colorSet = new Array<ItemColor>();
		
		for (colorId in GraphicsSheet.itemColors.keys())
		{
			var color:ItemColor = GraphicsSheet.itemColors[colorId];
			
			if (listType == GraphicsSheet.itemTypeToColorType(color.itemType))
			{
				colorSet.push(color);
			}
		}
		
		selectedColor = colorSet[0];
		
		var i:Int = 0;
		for (colorBox in colorBoxes)
		{
			colorBox.changeBoxColor(colorSet[i]);	
			i++;
		}
	}

	public function changeColor(colorId:Int)
	{
		RoomState.starboard.avatarWindow.itemList.changeItemColor(colorId);
	}

	private function closeButtonClicked(spr:FlxExtendedSprite, mouseX:Int, mouseY:Int)
	{
		this.visible = false;
	}
}
