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
	
	public var avatarMirror:FlxSprite;
	public var petMirror:FlxSprite;
	
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
		
		avatarMirror = new FlxSprite(21, -23, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_mirror_avatar.png"));
		avatarMaskSprite = new FlxSprite(0, 0, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_mirror_mask.png"));
		
		/*
		FlxG.watch.add(this, "x", "GameBarX");
		FlxG.watch.add(this, "y", "GameBarY");
		
		FlxG.watch.add(baseWood, "x", "BaseWoodX");
		FlxG.watch.add(baseWood, "y", "BaseWoodY");
		*/
		
		add(avatarMirror);
	}
	
	public function setReflections(avatarBmp:BitmapData)
	{
		var inSpr:FlxSprite = new FlxSprite(0, 0, avatarBmp);		
		var outSpr:FlxSprite = new FlxSprite(0, 0);
		
		FlxSpriteUtil.alphaMaskFlxSprite(inSpr, avatarMirror, outSpr);
	}
}