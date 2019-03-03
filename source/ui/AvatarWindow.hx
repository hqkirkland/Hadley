package ui;

import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

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
		
		var slotBox:SlotBox = new SlotBox();
		
		slotBoxes.add(slotBox);
		slotBox.enableMouseSpring();
		slotBox.lockPosition(5, 5);
		slotBoxes.members[0].setGameItem(7, 1);
		
		add(slotBoxes.members[0]);
	}
}