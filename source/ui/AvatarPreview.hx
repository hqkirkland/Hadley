package ui;

import openfl.display.BitmapData;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;
import flixel.math.FlxPoint;

import game.ClientData;
import game.Avatar.AvatarItem;
import game.ClothingType;
import game.ClothingItem;
import game.GraphicsSheet;
import game.ItemColor;

/**
 * ...
 * @author Hunter
 */
class AvatarPreview extends FlxSprite
{
	public var posX:Float;
	public var posY:Float;
	public var itemArray:Array<AvatarItem>;
	public var avatarSheet:GraphicsSheet = new GraphicsSheet(1772, 68);
	
	public var appearanceString:String;
	
	private static var frameSizePoint:FlxPoint = new FlxPoint(41, 68);

	public function new(_itemArray:Array<AvatarItem>, ?x:Float=0, ?y:Float=0):Void
	{
		super(x, y);
		set(_itemArray);
	}
	
	public function set(_itemArray:Array<AvatarItem>):Void
	{
		itemArray = _itemArray;
		regenerate();
	}
	
	public function regenerate():Void
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
				trace("Skipping " + _avatarItem.assetPath + "");
			}
			
			else
			{
				appearanceString += _avatarItem.gameItem.gameItemId + "^" + _avatarItem.itemColor + "^";
			}
			
			itemSprite.loadGraphic("assets/items/" + _avatarItem.assetPath + ".png");
			
			itemSprite.pixels = GraphicsSheet.colorItem(itemSprite.pixels, _avatarItem.itemColor, _avatarItem.gameItem.colorType);			
			avatarSheet.drawItem(itemSprite.pixels);
			i++;
		}
		
		var finalSeparatorPos:Int = appearanceString.lastIndexOf("^");
		
		if (finalSeparatorPos == appearanceString.length - 1)
		{
			appearanceString = appearanceString.substr(0, appearanceString.length - 1);
		}
		
		trace(appearanceString);
		
		//this.pixels = avatarSheet.bitmapData;
		
		generateAnimation();
		
		this.animation.play("StandSouthEast");
	}
		
	private function generateAnimation():Void
	{
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
	}
	
	public function clearItem(typeString:String)
	{
		var slot:Int = 0;
		
		switch (typeString)
		{
			case ClothingType.HAT:
				slot = 8;
			case ClothingType.GLASSES:
				slot = 7;
			case ClothingType.SHIRT:
				slot = 3;
			case ClothingType.PANTS:
				slot = 2;
			case ClothingType.SHOES:
				slot = 1;
		}
		
		if (itemArray[slot] == null)
		{
			return;
		}
		
		if (itemArray[slot].gameItem.layered)
		{
			if (itemArray[slot].gameItem.itemType == ClothingType.HAT)
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
	
	public function wearItem(wornItem:ClothingItem, ?colorId:Int=0)
	{
		var _avatarItem:AvatarItem = {
			gameItem: ClientData.clothingItems[wornItem.gameItemId], 
			assetPath: Std.string(wornItem.gameItemId),
			itemColor: colorId
		};
		
		switch (wornItem.itemType)
		{
			/*
			case ClothingType.BODY:
				itemArray[0]
			case ClothingType.FACE:
				itemArray[5]
			case ClothingType.HAIR:
				itemArray[6]
			*/
			
			case ClothingType.HAT:
				itemArray[8] = _avatarItem;
			case ClothingType.GLASSES:
				itemArray[7] = _avatarItem;
			case ClothingType.SHIRT:
				itemArray[3] = _avatarItem;
			case ClothingType.PANTS:
				itemArray[2] = _avatarItem;
			case ClothingType.SHOES:
				itemArray[1] = _avatarItem;
		}
		
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
}