package ui;

import RoomState;
import communication.NetworkManager;
import flixel.FlxG;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import ui.windows.WindowBase;
import ui.windows.WindowGroup;
import ui.windows.avatar.AvatarWindow;

/**
 * Base class for all UI objects.
 *
 * Represents isolation of the in-room manager (RoomState)
 * from any UI functions.
 *
 * All UI <-> Game interactions and reactions should pass
 * thru the main Starboard class.
 *
 * @author Hunter
 */
class StarboardInterface extends FlxSpriteGroup
{
	public var gameBar:GameBar;

	public var avatarWindow:AvatarWindow;

	public static var windowSystem:FlxTypedSpriteGroup<WindowGroup>;
	private static var lastAppearance:String;

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

			var bmp:BitmapData = new BitmapData(38, 56, true);
			bmp.copyPixels(RoomState.playerAvatar.pixels, new Rectangle(123, 0, 38, 56), new Point(0, 0));

			gameBar.setReflections(bmp);

			NetworkManager.sendChangeClothes(appearanceString);
			lastAppearance = appearanceString;
		}
	}

	// Strictly for GameBar -> Starboard calls
	public function gameBarInvoke(buttonClicked:FlxExtendedSprite, x:Int, y:Int):Void
	{
		if (buttonClicked == this.gameBar.playerMirror)
		{
			if (avatarWindow == null)
			{
				avatarWindow = new AvatarWindow();

				/*
					FlxG.watch.add(avatarWindow, "x", "avatarWindowX");
					FlxG.watch.add(avatarWindow, "y", "avatarWindowY");

					FlxG.watch.add(avatarWindow.mainWindow, "x", "avatarWindowBaseX");
					FlxG.watch.add(avatarWindow.mainWindow, "y", "avatarWindowBaseY");

					FlxG.watch.add(windowSystem, "x", "windowSystemX");
					FlxG.watch.add(windowSystem, "y", "windowSystemY");
				 */

				windowSystem.add(avatarWindow);
			}
			else if (!avatarWindow.visible)
			{
				avatarWindow.visible = true;
				bringToFront(avatarWindow.mainWindow);
			}
			else if (avatarWindow.visible)
			{
				bringToFront(avatarWindow.mainWindow);
			}
		}
	}

	public static function bringToFront(targetWindow:WindowBase)
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
