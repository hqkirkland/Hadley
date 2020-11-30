package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil;
import openfl.Assets;
import openfl.display.BitmapData;
import ui.windows.WindowGroup;
import ui.windows.avatar.AvatarWindow;

/**
 * ...
 * @author Hunter
 */
class GameBar extends FlxSpriteGroup
{
	public var baseWood:FlxSprite;
	public var chatBox:ChatInputBox;

	public var playerMirror:AvatarMirror;
	public var petMirror:FlxSprite;

	public function new()
	{
		super();
		this.width = 950;
		this.height = 100;

		baseWood = new FlxSprite(0, 0, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_base.png"));
		add(new FlxSprite(baseWood.x, baseWood.y, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_seal_left.png")));
		add(new FlxSprite(this.width - 28, baseWood.y, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_seal_right.png")));
		add(baseWood);

		chatBox = new ChatInputBox(0xFF232323, 238, -5);
		add(chatBox);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	public function setReflections(avatarBmp:BitmapData):Void
	{
		if (playerMirror == null)
		{
			playerMirror = new AvatarMirror();
			playerMirror.x = 21;
			playerMirror.y = -23;
		}

		else
		{
			remove(playerMirror);
		}

		playerMirror.setAppearance(avatarBmp);
		playerMirror.animation.play("Inactive");
		add(playerMirror);

		playerMirror.enableMouseClicks(true, false);
		playerMirror.mouseReleasedCallback = RoomState.starboard.gameBarInvoke;
	}
}
