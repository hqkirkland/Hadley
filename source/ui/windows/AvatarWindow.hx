package ui.windows;

import flixel.addons.display.FlxExtendedSprite;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

import game.ClothingType;

/**
 * ...
 * @author Hunter
 **/

class AvatarWindow extends Window
{
	private static var avatarContainer:FlxSprite;
	
	private static var hatSlotBox:WieldBox;
	private static var glassesSlotBox:WieldBox;
	private static var shirtSlotBox:WieldBox;
	private static var pantsSlotBox:WieldBox;
	private static var shoesSlotBox:WieldBox;
	
	private static var hatItemList:ItemList;
	private static var glassesItemList:ItemList;
	private static var shirtItemList:ItemList;
	private static var pantsItemList:ItemList;
	private static var shoesItemList:ItemList;
	
	private static var containerCornerTopRight:BitmapData;
	private static var containerCornerTopLeft:BitmapData;
	private static var containerCornerBottomRight:BitmapData;
	private static var containerCornerBottomLeft:BitmapData;
	
	private static var wieldBoxes:FlxTypedGroup<WieldBox>;
	private static var itemLists:FlxTypedGroup<ItemList>;
	private static var playerPreview:AvatarPreview;
	
	private static var changeButton:WindowButton;
	private static var colorPicker:ColorList;
/*
	public function new() 
	{
		super("Avatar", 200, 250);
		itemLists = new FlxTypedGroup<ItemList>();
		
		containerCornerTopRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_top_right.png");
		containerCornerTopLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_top_left.png");
		containerCornerBottomRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_bottom_right.png");
		containerCornerBottomLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_bottom_left.png");
		
		changeButton = new WindowButton(2, "starboard:assets/interface/starboard/elements/buttons/change_look.png");
		changeButton.addAnimation("", [0]);
		changeButton.addAnimation("clicked", [1], false, true);
		
		changeButton.mouseReleasedCallback = this.changeButtonClickCallback;
		
		colorPicker = new ColorList(ClothingType.DEFAULT_CLOTHING);
		// colorPicker.lockPosition((this.width / 2) - (colorPicker.width / 2), this.height);
		
		this.stamp(changeButton);
		this.stamp(colorPicker);
		
		makeContainer();
		placeBoxes();
		setupItemLists();
	}
	
	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		this.updateHitbox();
		
		for (itemList in itemLists)
		{
			if (itemList.newPicked)
			{
				if (itemList.selectedItem == null)
				{
					playerPreview.clearItem(itemList.listType);
				}
				
				else
				{
					playerPreview.wearItem(itemList.selectedItem);
				}
			}
			
			
			// itemList.x = baseWindow.x + itemList.posX;
			// itemList.y = baseWindow.y + itemList.posY;
			
		}
		
		if (colorPicker.newPicked)
		{
			// for now: determine the currently-open slot.
			// eventually: color picker per slot/clothing type, hide + replacement on switch
			
			for (itemList in itemLists)
			{
				if (itemList.visible && itemList.group != null)
				{
					trace(itemList.listType + ": " + colorPicker.selectedColor.colorId);
					playerPreview.colorItem(itemList.listType, colorPicker.selectedColor.colorId);
				}
			}
		}
		
		
		// playerPreview.x = avatarContainer.x + playerPreview.posX;
		// playerPreview.y = baseWindow.y + playerPreview.posY;
	}
	
	override private function closeWindow():Void
	{
		super.closeWindow();
		playerPreview.setLook(RoomState.playerAvatar.itemArray);
	}
	
	private function setElements():Void
	{
		
	}
	
	private function changeButtonClickCallback(_obj:FlxExtendedSprite, x:Int, y:Int):Void
	{
		trace(playerPreview.appearanceString);		
		RoomState.starboard.changeAppearance(playerPreview.appearanceString);
	}
	
	private function wieldBoxClickCallback(_obj:FlxExtendedSprite, x:Int, y:Int):Void
	{
		var wieldBox:WieldBox = cast(_obj, WieldBox);
		
		for (itemList in itemLists)
		{
			remove(itemList);
		}
		
		switch (wieldBox.clothingType)
		{
			case ClothingType.HAT:
				if (hatItemList.visible)
				{
					hatItemList.visible = false;
					remove(hatItemList);
				}
				
				else
				{
					hatItemList.visible = true;
					add(hatItemList);
				}
				
			case ClothingType.GLASSES:
				if (glassesItemList.visible)
				{
					glassesItemList.visible = false;
					remove(glassesItemList);
				}
				
				else
				{
					glassesItemList.visible = true;
					add(glassesItemList);
				}
				
			case ClothingType.SHIRT:
				if (shirtItemList.visible)
				{
					shirtItemList.visible = false;
					remove(shirtItemList);
				}
				
				else
				{
					shirtItemList.visible = true;
					add(shirtItemList);
				}
				
			case ClothingType.PANTS:
				if (pantsItemList.visible)
				{
					pantsItemList.visible = false;
					remove(pantsItemList);
				}
				
				else
				{
					pantsItemList.visible = true;
					add(pantsItemList);
				}
				
			case ClothingType.SHOES:
				if (shoesItemList.visible)
				{
					shoesItemList.visible = false;
					remove(shoesItemList);
				}
				
				else
				{
					shoesItemList.visible = true;
					add(shoesItemList);
				}
				
			default:
		}
	}
	
	private function makeContainer():Void
	{		
		avatarContainer = new FlxSprite(baseWindow.x + 12, baseWindow.y + 60);
		avatarContainer.pixels = new BitmapData(Math.floor(this.baseWindow.width) - 24, Math.ceil(this.baseWindow.height - 60 - 34), true, 0xFFFFFFFF);
		
		avatarContainer.pixels.copyPixels(containerCornerTopLeft, containerCornerTopLeft.rect, new Point(0, 0), null, null, true); 
		avatarContainer.pixels.copyPixels(containerCornerTopRight, containerCornerTopRight.rect, new Point(avatarContainer.width - 5, 0), null, null, true);
		avatarContainer.pixels.copyPixels(containerCornerBottomLeft, containerCornerBottomLeft.rect, new Point(0, avatarContainer.height - 5), null, null, true);
		avatarContainer.pixels.copyPixels(containerCornerBottomRight, containerCornerBottomRight.rect, new Point(avatarContainer.width - 5, avatarContainer.height - 5), null, null, true); 
		
		avatarContainer.pixels.threshold(avatarContainer.pixels, avatarContainer.pixels.rect, new Point(0, 0), "==", 0xFF00FF00);
		
		for (y in 5...(avatarContainer.pixels.height - 5))
		{
			avatarContainer.pixels.setPixel32(0, y, 0xFF989370);
			avatarContainer.pixels.setPixel32(avatarContainer.pixels.width - 1, y, 0xFF989370);
		}
		
		for (x in 5...(avatarContainer.pixels.width - 5))
		{
			avatarContainer.pixels.setPixel32(x, 0, 0xFF989370);
			avatarContainer.pixels.setPixel32(x, avatarContainer.pixels.height - 1, 0xFF989370);
		}
		
		add(avatarContainer);
		
		playerPreview = new AvatarPreview(RoomState.playerAvatar.itemArray);
		playerPreview.x = (avatarContainer.width / 2) - (playerPreview.width / 2);
		playerPreview.y = 100;
		add(playerPreview);
	}
	
	private function placeBoxes():Void
	{
		wieldBoxes = new FlxTypedGroup<WieldBox>(5);
		
		hatSlotBox = new WieldBox(ClothingType.HAT);
		glassesSlotBox = new WieldBox(ClothingType.GLASSES);
		shirtSlotBox = new WieldBox(ClothingType.SHIRT);
		pantsSlotBox = new WieldBox(ClothingType.PANTS);
		shoesSlotBox = new WieldBox(ClothingType.SHOES);
		
		hatSlotBox.mouseReleasedCallback = wieldBoxClickCallback;
		glassesSlotBox.mouseReleasedCallback = wieldBoxClickCallback;
		shirtSlotBox.mouseReleasedCallback = wieldBoxClickCallback;
		pantsSlotBox.mouseReleasedCallback = wieldBoxClickCallback;
		shoesSlotBox.mouseReleasedCallback = wieldBoxClickCallback;
		
		for (item in RoomState.playerAvatar.itemArray)
		{
			//trace(item.gameItem.itemType + ": " + item.gameItem.gameItemId + "^" + item.itemColor);
			
			if (item == null)
			{
				continue;
			}
			
			switch (item.gameItem.itemType)
			{
				case ClothingType.HAT:
					if (item.gameItem.layered && !hatSlotBox.validItemSet)
					{
						hatSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
					}
					
				case ClothingType.GLASSES:
					glassesSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
				case ClothingType.SHIRT:
					shirtSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
				case ClothingType.PANTS:
					pantsSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
				case ClothingType.SHOES:
					shoesSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
			}
		}
		
		wieldBoxes.add(hatSlotBox);
		wieldBoxes.add(glassesSlotBox);
		wieldBoxes.add(shirtSlotBox);
		wieldBoxes.add(pantsSlotBox);
		wieldBoxes.add(shoesSlotBox);
		
		hatSlotBox.lockPosition((avatarContainer.x - baseWindow.x) + 5, (avatarContainer.y - baseWindow.y) + 26);
		glassesSlotBox.lockPosition((avatarContainer.x - baseWindow.x) + 5, (avatarContainer.y - baseWindow.y) + 111);
		shirtSlotBox.lockPosition((avatarContainer.x - baseWindow.x + avatarContainer.width) - (5 + shirtSlotBox.width), (avatarContainer.y - baseWindow.y) + 26);
		pantsSlotBox.lockPosition((avatarContainer.x - baseWindow.x + avatarContainer.width) - (5 + pantsSlotBox.width), (avatarContainer.y - baseWindow.y) + 68);
		shoesSlotBox.lockPosition((avatarContainer.x - baseWindow.x + avatarContainer.width) - (5 + shoesSlotBox.width), (avatarContainer.y - baseWindow.y) + 111);
		
		for (member in wieldBoxes)
		{
			add(member);
		}
	}
	
	private function setupItemLists():Void
	{
		hatItemList = new ItemList(ClothingType.HAT);
		hatItemList.lockPosition(-1 * hatItemList.width, 75);
		
		glassesItemList = new ItemList(ClothingType.GLASSES);
		glassesItemList.lockPosition(-1 * glassesItemList.width, 150);
		
		shirtItemList = new ItemList(ClothingType.SHIRT);
		shirtItemList.lockPosition(baseWindow.width, 75);
		
		pantsItemList = new ItemList(ClothingType.PANTS);
		pantsItemList.lockPosition(baseWindow.width, 112);
		
		shoesItemList = new ItemList(ClothingType.SHOES);
		shoesItemList.lockPosition(baseWindow.width, 150);

		itemLists.add(hatItemList);
		itemLists.add(glassesItemList);
		itemLists.add(shirtItemList);
		itemLists.add(pantsItemList);
		itemLists.add(shoesItemList);
		
		add(hatItemList);
		add(glassesItemList);
		add(shirtItemList);
		add(pantsItemList);
		add(shoesItemList);
		
		for (itemList in itemLists)
		{
			itemList.visible = false;
			remove(itemList);
		}
	}
	*/
}