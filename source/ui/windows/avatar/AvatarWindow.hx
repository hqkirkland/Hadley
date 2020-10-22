package ui.windows.avatar;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

import game.ClothingType;
import game.ClothingItem;

/**
 * ...
 * @author Hunter
 **/

class AvatarWindow extends WindowGroup
{
    public var itemList:ItemList;

    public static var playerPreview:AvatarPreview;

    private static var avatarContainer:WindowItem;
    private static var hatSlotBox:WieldBox;
    private static var glassesSlotBox:WieldBox;
    private static var shirtSlotBox:WieldBox;
    private static var pantsSlotBox:WieldBox;
    private static var shoesSlotBox:WieldBox;
    private static var changeButton:WindowButton;
    private static var colorPicker:ColorList;

    public function new():Void
    {
        super("Avatar", 250, 200, 100, 100);
        
        hatSlotBox = new WieldBox(Math.ceil(this.width) - 20 - 38, 40, ClothingType.HAT);
        shirtSlotBox = new WieldBox(Math.ceil(this.width) - 20 - 38, 90, ClothingType.SHIRT);
		pantsSlotBox = new WieldBox(Math.ceil(this.width) - 20 - 38, 140, ClothingType.PANTS);
		glassesSlotBox = new WieldBox(20, 40, ClothingType.GLASSES);
        shoesSlotBox = new WieldBox(20, 140, ClothingType.SHOES);
        
        playerPreview = new AvatarPreview(RoomState.playerAvatar.itemArray, 105, 68);
        
        setGameItems();
        
        add(hatSlotBox);
        add(shirtSlotBox);
        add(pantsSlotBox);
        add(glassesSlotBox);
        add(shoesSlotBox);

        add(playerPreview);
    }

    public function updateItemList(itemListType:String)
    {
        if (itemList == null)
        {
            itemList = new ItemList(itemListType, 0, 50, 50);
        }

        add(itemList);

        /*
        else
        {
            if (itemListType != itemList.listType)
            {
                //itemList.resetList(itemListType);
            }
        }

        for (member in itemList.members)
        {
            add(member);
        }
        */
    }

    private function setGameItems()
    {
        var itemIndex:Int = 0;
        
        for (item in RoomState.playerAvatar.itemArray)
        {
			// Skip null items, and the fourth item.
			// itemArray is the actual figure of the Avatar.
			// The fourth item is the back of the hat, if it is two-halved.
            // Like Monk's hat is.
            
            if (item == null || itemIndex == 4)
            {
                itemIndex++;
                continue;
			}

            switch (item.gameItem.itemType)
            {
                case ClothingType.GLASSES:
                    glassesSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
                case ClothingType.SHIRT:
                    shirtSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
                case ClothingType.PANTS:
                    pantsSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
                case ClothingType.SHOES:
					shoesSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
				case ClothingType.HAT:
					hatSlotBox.setGameItem(item.gameItem.gameItemId, item.itemColor);
			}
			
			itemIndex++;
		}
    }
}