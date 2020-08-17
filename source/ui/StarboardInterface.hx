package ui;

import ui.windows.WindowGroup;
import flixel.addons.display.FlxExtendedSprite;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;

import RoomState;
import communication.NetworkManager;
import game.ClientData;

import ui.windows.WindowBase;
import ui.windows.avatar.AvatarWindow;

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
	public var avatarWindow:AvatarWindow;
	
	public static var windowSystem:FlxTypedSpriteGroup<WindowGroup>;
	public static var lastAppearance:String;
	
	public function new() 
	{
		super();
		
		gameBar = new GameBar();
		gameBar.x = 0;
		gameBar.y = FlxG.height - Math.floor(gameBar.baseWood.height) + 1;
		
		windowSystem = new FlxTypedSpriteGroup<WindowGroup>();

		add(gameBar);
		add(windowSystem);

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

	public function invokeWindow(buttonClicked:FlxExtendedSprite, x:Int, y:Int):Void
	{
		if (avatarWindow != null)
		{
			avatarWindow.visible = true;
		}

		// TODO: Generate window by identifying clicked Sprite.
		avatarWindow = new AvatarWindow();
		avatarWindow.enableMouseDrag();
		windowSystem.add(avatarWindow);
	}

	public function bringToFront(targetWindow:WindowBase)
	{
		for (window in windowSystem)
		{
			if (window.mainWindow == targetWindow)
			{
				windowSystem.remove(window, true);
				windowSystem.add(window);
			}
		}
	}
}