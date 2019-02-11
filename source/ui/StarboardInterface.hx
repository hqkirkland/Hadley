package ui;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.AssetLibrary;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author Hunter
 */

class StarboardInterface extends FlxSpriteGroup
{
	public var gameBar:GameBar;
	
	public function new() 
	{
		super();
		
		Assets.loadLibrary("starboard").onComplete(libraryLoaded);	
	}
	
	private function libraryLoaded(completeLib:AssetLibrary):Void
	{
		Assets.registerLibrary("starboard", completeLib);
		
		gameBar = new GameBar();
		gameBar.x = 0;
		gameBar.y = FlxG.height - Math.ceil(gameBar.baseWood.height);
		add(gameBar);
		
		forEach(
			function(sprite:FlxSprite)
			{
				sprite.scrollFactor.set(0, 0);
			}
		);
	}
	
	public function setMirrorLook(avatarBmp:BitmapData)
	{
		var bmp:BitmapData = new BitmapData(38, 56, true);
		bmp.copyPixels(avatarBmp, new Rectangle(123, 0, 38, 56), new Point(0, 0));
		
		gameBar.setReflections(bmp);
	}
}