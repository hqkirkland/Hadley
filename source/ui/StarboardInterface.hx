package ui;

import RoomState;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
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
 * I don't think this class should make use of any NetworkManager features..
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
		windowSystem.width = FlxG.width;
		windowSystem.height = FlxG.height;

		add(gameBar);
		add(windowSystem);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	public function changeAppearance(appearanceString:String):Void
	{
		// Networking code moved.
		if (appearanceString != lastAppearance)
		{
			var bmp:BitmapData = new BitmapData(38, 56, true);
			bmp.copyPixels(RoomState.playerAvatar.pixels, new Rectangle(123, 0, 38, 56), new Point(0, 0));

			gameBar.setReflections(bmp);

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
				avatarWindow.x = 100;
				avatarWindow.y = 100;

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
