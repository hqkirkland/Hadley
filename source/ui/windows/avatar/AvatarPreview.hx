package ui.windows.avatar;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;
import flixel.math.FlxPoint;

import game.avatar.AvatarAppearance;
import game.items.GameItem;
import game.GraphicsSheet;

/**
 * ...
 * @author Hunter
 */
class AvatarPreview extends WindowItem
{
	public var appearance:AvatarAppearance;

	public var avatarSheet:GraphicsSheet = new GraphicsSheet(1772, 68);

	private static var frameSizePoint:FlxPoint = new FlxPoint(41, 68);

	public function new(appearanceStr:String, ?x:Int = 0, ?y:Int = 0):Void
	{
		super(x, y);

		appearance = new AvatarAppearance(appearanceStr);
		regenerate();
	}

	private function regenerate():Void
	{
		avatarSheet = new GraphicsSheet(1772, 68);

		var itemSprite:FlxSprite = new FlxSprite(0, 0);

		for (_avatarItem in appearance.itemArray)
		{
			if (_avatarItem != null)
			{
				itemSprite.loadGraphic("assets/items/" + _avatarItem.assetPath + ".png");
				avatarSheet.drawItem(GraphicsSheet.colorItem(itemSprite.pixels, _avatarItem.itemColor, _avatarItem.gameItem.colorType));
			}
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

	public function wearItem(wornItem:GameItem, ?colorId:Int = 0)
	{
		appearance.wearItem(wornItem.gameItemId, colorId);
		regenerate();
	}

	public function colorItem(typeString:String, ?colorId:Int = 0)
		{
			appearance.colorItem(typeString, colorId);
			regenerate();
		}
	
	public function clearItem(typeString:String)
	{
		appearance.clearItem(typeString);
		regenerate();
	}
}
