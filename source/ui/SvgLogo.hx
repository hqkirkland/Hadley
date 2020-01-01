package ui;
import format.SVG;
import openfl.display.BitmapData;
import openfl.display.Sprite;

import flixel.FlxSprite;

import openfl.Assets;
import openfl.display.Graphics;
import openfl.display.Bitmap;

/**
 * ...
 * @author ...
 */
class SvgLogo extends Bitmap
{
	private var svg:SVG;
	
	public function new() 
	{
		super(new BitmapData(440, 120));
	}
}