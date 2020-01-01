package ui;

import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;

import game.GraphicsSheet;
import game.ItemColor;

/**
 * ...
 * @author Hunter
 */
class ColorList extends FlxTypedSpriteGroup<FlxExtendedSprite>
{
	public var colorSet:Array<ItemColor> = new Array<ItemColor>();
	public var posX:Float;
	public var posY:Float;
	public var selectedColor:ItemColor;
	public var newPicked:Bool = false;
	
	private var colorType:Int;

	private static var pastePoint:Point = new Point(4, 4);
	
	public function new(itemType:String) 
	{
		super(0, 0);

		var mainSprite:FlxExtendedSprite = new FlxExtendedSprite(0, 0);
		mainSprite.loadGraphic(Assets.getBitmapData("starboard:assets/interface/starboard/elements/color_grid_container.png"));
		add(mainSprite);
		
		colorType = GraphicsSheet.itemTypeToColorType(itemType);
		
		for (colorId in GraphicsSheet.avatarColors.keys())
		{
			var color:ItemColor = GraphicsSheet.avatarColors[colorId];
			var itemColorType:Int = GraphicsSheet.itemTypeToColorType(color.itemType);
			
			if (this.colorType == itemColorType)
			{
				colorSet.push(color);
			}
		}
		
		selectedColor = colorSet[0];
		
		buildSet();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		for (i in 0...this.members.length)
		{
			if (newPicked)
			{
				if (colorSet.length > i - 1)
				{
					if (selectedColor == colorSet[i - 1])
					{
						newPicked = false;
					}
				}
			}
			
			else if (this.members[i].isPressed && i != 0)
			{
				if (colorSet.length > i - 1)
				{
					if (selectedColor != colorSet[i - 1])
					{
						selectedColor = colorSet[i - 1];
						newPicked = true;
						trace(selectedColor);
					}
					
					else
					{
						newPicked = false;
					}
				}
			}
		}
	}
	
	public function lockPosition(relativeX:Float, relativeY:Float):Void
	{
		posX = relativeX;
		posY = relativeY;
	}
	
	private function buildSet():Void
	{
		var nx:Int = 0;
		var ny:Int = 0;
		
		for (color in colorSet)
		{
			nx = nx % 6;
			
			pastePoint.x = 5 + (nx * 16);
			pastePoint.y = 5 + (ny * 16);
			
			var colorSpr:FlxExtendedSprite = new FlxExtendedSprite(pastePoint.x, pastePoint.y, constructColor(color));
			colorSpr.mousePressedCallback = colorPressed;
			
			this.add(colorSpr);
			// this.pixels.copyPixels(constructColor(color), copyFromRect, pastePoint);
			
			nx++;
			
			if (nx % 6 == 0)
			{
				ny++;
			}
		}
	}
	
	private function colorPressed(_obj:FlxExtendedSprite, x:Int, y:Int):Void
	{
		var colorIndex:Int = this.members.indexOf(_obj);
		
		if (colorIndex != -1 && colorIndex != 0)
		{
			if (colorSet.length > colorIndex)
			{
				if (selectedColor.colorId != colorSet[colorIndex].colorId)
				{
					selectedColor = colorSet[colorIndex];
					newPicked = true;
					trace(selectedColor);
				}
				
				else
				{
					newPicked = false;
				}
			}
			
			else
			{
				newPicked = false;
			}
		}
		
		else
		{
			newPicked = false;
		}
	}
	
	private function constructColor(color:ItemColor):BitmapData
	{
		var bmp:BitmapData = new BitmapData(14, 16, false, color.channel1);
		
		for (ny in 0...5)
		{
			for (nx in 0...12)
			{
				bmp.setPixel(nx + 1, ny + 1, color.channel2);
			}
		}
		
		return bmp;
	}
	
}