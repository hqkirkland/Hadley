package ui;

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
	
	private static var containerCornerTopRight:BitmapData;
	private static var containerCornerTopLeft:BitmapData;
	private static var containerCornerBottomRight:BitmapData;
	private static var containerCornerBottomLeft:BitmapData;
	
	private static var slotBoxes:FlxTypedGroup<SlotBox>;
	
	public function new() 
	{
		super("Avatar", 200, 250, 300, 100);
		
		containerCornerTopRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_top_right.png");
		containerCornerTopLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_top_left.png");
		containerCornerBottomRight = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_bottom_right.png");
		containerCornerBottomLeft = Assets.getBitmapData("starboard:assets/interface/starboard/elements/element_container_rounded_bottom_left.png");
		
		makeContainer();
		placeBoxes();
	}
	
	override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		avatarContainer.x = baseWindow.x + 12;
		avatarContainer.y = baseWindow.y + 60;
		
		for (slotBox in slotBoxes)
		{
			slotBox.x = baseWindow.x + slotBox.posX;
			slotBox.y = baseWindow.y + slotBox.posY;
		}
	}
	
	private function makeContainer():Void
	{
		avatarContainer = new FlxSprite(12, 60);
		avatarContainer.pixels = new BitmapData(Math.floor(this.baseWindow.width) - 24, Math.ceil(this.baseWindow.height - 60 - 14), true, 0xFFFFFFFF);
		
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
	}
	
	private function placeBoxes():Void
	{
		slotBoxes = new FlxTypedGroup<SlotBox>(5);
		
		var hatSlotBox:SlotBox = new SlotBox();
		var glassesSlotBox:SlotBox = new SlotBox();
		var shirtSlotBox:SlotBox = new SlotBox();
		var pantsSlotBox:SlotBox = new SlotBox();
		var shoesSlotBox:SlotBox = new SlotBox();
		
		for (item in RoomState.playerAvatar.itemArray)
		{
			//trace(item.gameItem.itemType + ": " + item.gameItem.gameItemId + "^" + item.itemColor);
			
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
		
		slotBoxes.add(hatSlotBox);
		slotBoxes.add(glassesSlotBox);
		slotBoxes.add(shirtSlotBox);
		slotBoxes.add(pantsSlotBox);
		slotBoxes.add(shoesSlotBox);
		
		hatSlotBox.lockPosition((avatarContainer.x - baseWindow.x) + 5, (avatarContainer.y - baseWindow.y) + 30);
		glassesSlotBox.lockPosition((avatarContainer.x - baseWindow.x) + 5, (avatarContainer.y - baseWindow.y) + 115);
		
		shirtSlotBox.lockPosition((avatarContainer.x - baseWindow.x + avatarContainer.width) - (5 + shirtSlotBox.width), (avatarContainer.y - baseWindow.y) + 30);
		pantsSlotBox.lockPosition((avatarContainer.x - baseWindow.x + avatarContainer.width) - (5 + pantsSlotBox.width), (avatarContainer.y - baseWindow.y) + 72);
		shoesSlotBox.lockPosition((avatarContainer.x - baseWindow.x + avatarContainer.width) - (5 + shoesSlotBox.width), (avatarContainer.y - baseWindow.y) + 115);
		
		for (member in slotBoxes)
		{
			add(member);
		}
	}
}