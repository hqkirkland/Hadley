package ui;

import flixel.addons.plugin.FlxMouseControl;
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
	public var windowSystem:FlxTypedSpriteGroup<Window>;
	
	public function new() 
	{
		super();
		
		gameBar = new GameBar();
		gameBar.x = 0;
		gameBar.y = FlxG.height - Math.ceil(gameBar.baseWood.height);
		add(gameBar);
		
		FlxG.plugins.add(new FlxMouseControl());
		FlxMouseControl.mouseZone = this.clipRect;
		
		forEach(
			function(sprite:FlxSprite)
			{
				sprite.scrollFactor.set(0, 0);
			}
		);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(gameBar.playerMirror))
		{
			if (gameBar.sampleWindow == null)
			{
				gameBar.sampleWindow = new Window("Title", 200, 200, 300, 300);
				add(gameBar.sampleWindow);
			}
			
			else if (!gameBar.sampleWindow.visible)
			{
				gameBar.sampleWindow.visible = true;
				add(gameBar.sampleWindow);
			}
			
			else
			{
				gameBar.sampleWindow.visible = false;
				remove(gameBar.sampleWindow);
			}
		}
	}
	
	public function setMirrorLook(avatarBmp:BitmapData)
	{
		var bmp:BitmapData = new BitmapData(38, 56, true);
		bmp.copyPixels(avatarBmp, new Rectangle(123, 0, 38, 56), new Point(0, 0));
		
		gameBar.setReflections(bmp);
	}
}