package ui;

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
 */
class AvatarWindow extends Window
{
	private static var avatarContainer:FlxSprite;
	
	private static var hatSlotBox:WieldBox;
	private static var glassesSlotBox:WieldBox;
	private static var shirtSlotBox:WieldBox;
	private static var pantsSlotBox:WieldBox;
	private static var shoesSlotBox:WieldBox;
	
	private static var hatItemList:ItemList;
	
	private static var containerCornerTopRight:BitmapData;
	private static var containerCornerTopLeft:BitmapData;
	private static var containerCornerBottomRight:BitmapData;
	private static var containerCornerBottomLeft:BitmapData;
	
	private static var wieldBoxes:FlxTypedGroup<WieldBox>;
	private static var playerPreview:AvatarPreview;
	
	private static var changeButton:WindowButton;
	
	public function new() 
	{
		super("Avatar", 200, 250, 300, 100);
		
		containerCornerTopRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_top_right.png");
		containerCornerTopLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_top_left.png");
		containerCornerBottomRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_bottom_right.png");
		containerCornerBottomLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_bottom_left.png");
		
		changeButton = new WindowButton(2, "starboard:assets/interface/starboard/elements/buttons/change_look.png");
		changeButton.addAnimation("", [0]);
		changeButton.addAnimation("clicked", [1], false, true);
		
		changeButton.mouseReleasedCallback = this.changeButtonClickCallback;
		add(changeButton);
		
		makeContainer();
		placeBoxes();
	}
	
	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		changeButton.x = baseWindow.x + baseWindow.width - changeButton.width - 10;
		changeButton.y = baseWindow.y + baseWindow.height - changeButton.height - 10;
		
		avatarContainer.x = baseWindow.x + 12;
		avatarContainer.y = baseWindow.y + 60;
		
		for (wieldBox in wieldBoxes)
		{
			wieldBox.x = baseWindow.x + wieldBox.posX;
			wieldBox.y = baseWindow.y + wieldBox.posY;
		}
		
		playerPreview.x = avatarContainer.x + playerPreview.posX;
		playerPreview.y = baseWindow.y + playerPreview.posY;
		
		if (hatSlotBox.isPressed)
		{
			/*
			playerPreview.clearItem(ClothingType.HAT);
			hatSlotBox.clearGameItem();
			*/
			
			// This is where it would help to have an avatar body data structure.
			// Could check to see if the item in the slot is the hat the user has equipped.
			
			if (hatItemList == null)
			{
				hatItemList = new ItemList(ClothingType.HAT, baseWindow.x - 129, baseWindow.y + 30);
				add(hatItemList);
			}
			
			else if (!hatItemList.visible)
			{
				add(hatItemList);
				hatItemList.visible = true;
			}
			
			else
			{
				remove(hatItemList);
				hatItemList.visible = false;
			}
		}
		
		if (hatItemList != null)
		{
			hatItemList.x = baseWindow.x - hatItemList.width;
			hatItemList.y = baseWindow.y + 100;
		}
		
		
		if (glassesSlotBox.isPressed)
		{
			playerPreview.clearItem(ClothingType.GLASSES);
			glassesSlotBox.clearGameItem();
		}
		
		if (shirtSlotBox.isPressed)
		{
			playerPreview.clearItem(ClothingType.SHIRT);
			shirtSlotBox.clearGameItem();
		}
		
		if (pantsSlotBox.isPressed)
		{
			playerPreview.clearItem(ClothingType.PANTS);
			pantsSlotBox.clearGameItem();
		}
		
		if (shoesSlotBox.isPressed)
		{
			playerPreview.clearItem(ClothingType.SHOES);
			shoesSlotBox.clearGameItem();
		}
	}
	
	override private function closeWindow():Void
	{
		super.closeWindow();
		playerPreview.set(RoomState.playerAvatar.itemArray);
	}
	
	private function changeButtonClickCallback(_obj:FlxExtendedSprite, x:Int, y:Int)
	{
		trace(playerPreview.appearanceString);
		
		RoomState.starboard.changeAppearance(playerPreview.appearanceString);
	}
	
	private function makeContainer():Void
	{
		avatarContainer = new FlxSprite(12, 60);
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
		playerPreview.posX = (avatarContainer.width / 2) - (playerPreview.width / 2);
		playerPreview.posY = 100;
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
}