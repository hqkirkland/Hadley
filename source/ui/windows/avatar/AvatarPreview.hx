package ui.windows.avatar;

import openfl.display.BitmapData;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;
import flixel.math.FlxPoint;

import game.ClientData;
import game.AvatarItem;
import game.ClothingType;
import game.ClothingItem;
import game.GraphicsSheet;
import game.ItemColor;

/**
 * ...
 * @author Hunter
 */
class AvatarPreview extends WindowItem
{
	public var itemArray:Array<AvatarItem>;
	public var avatarSheet:GraphicsSheet = new GraphicsSheet(1772, 68);
	
	public var appearanceString:String;
	
	private static var frameSizePoint:FlxPoint = new FlxPoint(41, 68);

	public function new(?playerItemArray:Array<AvatarItem>, ?x:Int=0, ?y:Int=0):Void
	{
		super(x, y);

		if (playerItemArray != null)
		{
			setLook(playerItemArray);
		}
	}
	
	public function setLook(_itemArray:Array<AvatarItem>):Void
	{
		itemArray = _itemArray;
		regenerate();
	}
	
	private function regenerate():Void
	{
		avatarSheet = new GraphicsSheet(1772, 68);
		
		var itemSprite:FlxSprite = new FlxSprite(0, 0);
		
		appearanceString = "";
		
		var i:Int = 0;
		
		for (_avatarItem in itemArray)
		{
			if (_avatarItem == null)
			{
				if (i != 4)
				{
					appearanceString += "0^0^";
				}
				
				continue;
			}

			else if (_avatarItem.assetPath == _avatarItem.gameItem.layeredAsset)
			{
				trace("Skipping " + _avatarItem.assetPath);
			}
			
			else
			{
				appearanceString += _avatarItem.gameItem.gameItemId + "^" + _avatarItem.itemColor + "^";
			}
			
			itemSprite.loadGraphic("assets/items/" + _avatarItem.assetPath + ".png");
			avatarSheet.drawItem(GraphicsSheet.colorItem(itemSprite.pixels, _avatarItem.itemColor, _avatarItem.gameItem.colorType));
			
			i++;
		}
		
		var finalSeparatorPos:Int = appearanceString.lastIndexOf("^");
		
		if (finalSeparatorPos == appearanceString.length - 1)
		{
			appearanceString = appearanceString.substr(0, appearanceString.length - 1);
		}

		this.frames = FlxTileFrames.fromGraphic(FlxGraphic.fromBitmapData(avatarSheet.bitmapData), frameSizePoint);
		
		this.animation.add("StandNorth", [0], 0, false, false);
		this.animation.add("StandNorthEast", [1], 0, false, false);
		this.animation.add("StandEast", [2], 0, false, false);
		this.animation.add("StandSouthEast", [3], 0, false, false);
		this.animation.add("StandSouth", [4], 0, false, false);
		this.animation.add("StandNorthWest", [1], 0, false, true);
		this.animation.add("StandWest", [2], 0, false, true);
		this.animation.add("StandSouthWest", [3], 0, false, true);

		this.setGraphicSize(41 * 2, 68 * 2);

		this.animation.play("StandSouthEast");
		// TODO: Add figure rotate buttons
	}

	public function colorItem(typeString:String, ?colorId:Int = 0)
	{
		var slot:Int = ClothingType.typeToNum(typeString);
		
		itemArray[slot].itemColor = colorId;
		
		if (itemArray[slot] == null)
		{
			return;
		}
		
		regenerate();
	}
	
	public function wearItem(wornItem:ClothingItem, ?colorId:Int=0)
	{
		var _avatarItem:AvatarItem = {
			gameItem: ClientData.clothingItems[wornItem.gameItemId], 
			assetPath: Std.string(wornItem.gameItemId),
			itemColor: colorId
		};

		var itemTypePosition:Int = ClothingType.typeToNum(wornItem.itemType);
		itemArray[itemTypePosition] = _avatarItem;
		
		if (_avatarItem.gameItem.layered)
		{
			var layerItem:AvatarItem = {
				gameItem: ClientData.clothingItems[wornItem.gameItemId],
				assetPath: ClientData.clothingItems[wornItem.gameItemId].layeredAsset,
				itemColor: colorId
			};
			
			itemArray[4] = layerItem;
		}
		
		regenerate();
	}
	
	public function isSlotClear(typeString:String)
	{
		var slot:Int = ClothingType.typeToNum(typeString);
		
		if (itemArray[slot] == null)
		{
			return true;
		}
		
		return false;
	}
	
	public function clearItem(typeString:String)
	{
		var slot:Int = ClothingType.typeToNum(typeString);

		if (slot == -1 || itemArray[slot] == null)
		{
			return;
		}
		
		if (itemArray[slot].gameItem.layered)
		{
			// Also gotta empty the hat!
			if (typeString == ClothingType.HAT)
			{
				itemArray[4] = null;
			}
		}
		
		if (slot != 0)
		{
			itemArray[slot] = null;
		}
		
		regenerate();
	}
	
	public function isWearingItem(checkedItem:ClothingItem):Bool
	{
		var slot:Int = ClothingType.typeToNum(checkedItem.itemType);

		if (itemArray[slot] != null)
		{
			return itemArray[slot].gameItem.gameItemId == checkedItem.gameItemId;
		}
		
		return false;
	}
}