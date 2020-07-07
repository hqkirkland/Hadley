package ui.windows.avatar;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
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

class AvatarWindow extends WindowGroup
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
	
	private static var wieldBoxes:FlxTypedGroup<WieldBox>;
	private static var itemLists:FlxTypedGroup<ItemList>;
	private static var playerPreview:AvatarPreview;
	
	private static var changeButton:WindowButton;
	private static var colorPicker:ColorList;

	public function new():Void
	{
		super("Avatar", 200, 250, 100, 100);
		
		hatSlotBox = new WieldBox(ClothingType.HAT, 30, 40);
		add(hatSlotBox);
		hatSlotBox.setGameItem(RoomState.playerAvatar.itemArray[])
	}
}