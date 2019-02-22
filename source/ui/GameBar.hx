package ui;

import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSpriteUtil;

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
	public var sampleWindow:Window;
	
	private var avatarMaskSprite:FlxSprite;

	public function new() 
	{
		super();
		this.width = 950;
		this.height = 100;
		
		baseWood = new FlxSprite(0, 0, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_base.png"));
		add(baseWood);
		
		add(new FlxSprite(baseWood.x, baseWood.y, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_seal_left.png")));
		add(new FlxSprite(this.width - 29, baseWood.y, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_seal_right.png")));
		
		chatBox = new ChatInputBox(0xFF232323, 238, -5);
		add(chatBox);
		
		playerMirror = new AvatarMirror();
		playerMirror.x = 21;
		playerMirror.y = -23;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	public function setReflections(avatarBmp:BitmapData):Void
	{
		playerMirror.setAppearance(avatarBmp);
		playerMirror.animation.play("Inactive");
		add(playerMirror);
	}
}