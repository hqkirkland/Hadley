package ui;

import flixel.addons.display.FlxExtendedSprite;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

import RoomState;
import ui.windows.Window;
import communication.NetworkManager;
import game.ClientData;

/**
 * Base class for all UI objects.
 * 
 * Represents isolation of the in-room manager (RoomState)
 * from any UI functions.
 * 
 * @author Hunter
 */

class StarboardInterface extends FlxSpriteGroup
{
	public var gameBar:GameBar;
	
	public static var lastAppearance:String;
	
	public function new() 
	{
		super();
		
		gameBar = new GameBar();
		gameBar.x = 0;
		gameBar.y = FlxG.height - Math.floor(gameBar.baseWood.height) + 1;
		add(gameBar);
		
		this.scrollFactor.set(0, 0);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	public function changeAppearance(appearanceString:String):Void
	{
		if (appearanceString != lastAppearance)
		{
			RoomState.playerAvatar.setAppearance(appearanceString);
			setMirrorLook(RoomState.playerAvatar.pixels);
			NetworkManager.sendChangeClothes(appearanceString);
			
			lastAppearance = appearanceString;
		}
	}
	
	public function setMirrorLook(avatarBmp:BitmapData):Void
	{
		var bmp:BitmapData = new BitmapData(38, 56, true);
		bmp.copyPixels(avatarBmp, new Rectangle(123, 0, 38, 56), new Point(0, 0));
		
		gameBar.setReflections(bmp);
	}

	public function invokeWindow(obj:FlxExtendedSprite, x:Int, y:Int):Void
	{
		var newWindow:Window = new ui.windows.Window("Test Window", 100, 100);
		newWindow.enableMouseDrag();
		
		add(newWindow);
	}
}
