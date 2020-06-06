package ui;

import flixel.addons.display.FlxExtendedSprite;
import flixel.math.FlxPoint;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;

/**
 * ...
 * @author Hunter
 */
class AvatarMirror extends FlxExtendedSprite
{
	private var mirrorSprite:FlxSprite;
	
	private static var mirrorMask:FlxSprite;
	
	public function new(?x:Float, ?y:Float)
	{
		super(0, 0);
		
		mirrorMask = new FlxSprite(0, 0, Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_mirror_mask.png"));
		
		this.pixels = Assets.getBitmapData("starboard:assets/interface/starboard/elements/gamebar/gamebar_mirror_avatar.png");
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (FlxG.mouse.overlaps(this))
		{
			if (animation.name != "Halo")
			{
				animation.play("Halo");
			}

			if (FlxG.mouse.pressed)
			{
				
			}
		}
		
		else
		{
			animation.play("Inactive");
		}
	}
	
	public function setAppearance(avatarBmp:BitmapData):Void
	{		
		avatarBmp.threshold(avatarBmp, avatarBmp.rect, new Point(0, 0), "==", 0x00000000, 0xFF00FF00);
		
		var inSpr:FlxSprite = new FlxSprite(0, 0, avatarBmp);
		var outSpr:FlxSprite = new FlxSprite(0, 0);
		
		FlxSpriteUtil.alphaMaskFlxSprite(inSpr, mirrorMask, outSpr);
		
		outSpr.pixels.threshold(outSpr.pixels, avatarBmp.rect, new Point(0, 0), "==", 0xFF00FF00, 0x00000000);
		
		stamp(outSpr, 0, 6);
		stamp(outSpr, 38, 6);
		stamp(outSpr, 76, 6);
		
		this.frames = FlxTileFrames.fromGraphic(FlxGraphic.fromBitmapData(this.pixels), new FlxPoint(38, 56));
		
		this.animation.add("Inactive", [0], 0, false);
		this.animation.add("Halo", [1, 2], 45, false);
	}
}