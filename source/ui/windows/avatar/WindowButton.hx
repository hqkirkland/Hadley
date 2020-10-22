package ui.windows.avatar;

import flixel.math.FlxPoint;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;
import flixel.addons.display.FlxExtendedSprite;

/**
 * ...
 * @author Hunter
 */
class WindowButton extends FlxExtendedSprite
{
	public var hoverAnimation:String;
	public var clickAnimation:String;
	
	public function new(frameCount:Int, asset:String, ?xOrientedFrames:Bool=true, ?x:Float, ?y:Float)
	{
		super(0, 0);
		
		this.clickable = true;
		
		this.pixels = Assets.getBitmapData(asset);
		
		if (xOrientedFrames)
		{
			this.frameWidth = Math.floor(this.pixels.width / frameCount);
			this.frameHeight = Math.floor(this.pixels.height);
		}
		
		else
		{
			this.frameWidth = Math.floor(this.pixels.width);
			this.frameHeight = Math.floor(this.pixels.height / frameCount);
		}
		
		this.frames = FlxTileFrames.fromGraphic(FlxGraphic.fromBitmapData(this.pixels), new FlxPoint(this.frameWidth, this.frameHeight));
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (hoverAnimation != null)
		{
			if (FlxG.mouse.overlaps(this))
			{
				if (animation.name != hoverAnimation)
				{
					animation.play(hoverAnimation);
				}
			}
		}
		

		if (FlxG.mouse.overlaps(this) && this.isPressed)
		{
			if (clickAnimation != null && this.clickable)
			{
				if (animation.name != clickAnimation)
				{
					animation.play(clickAnimation);
				}
			}

			else
			{
				animation.play("inactive");
			}
		}
	}
	
	public function addAnimation(animationName:String, frameSet:Array<Int>, ?isHoverAnimation:Bool=false, ?isClickAnimation:Bool=false):Void
	{
		if (animationName == "")
		{
			animationName = "inactive";
		}
		
		for (n in frameSet)
		{
			if (n >= this.frames.numFrames)
			{
				frameSet.remove(n);
			}
		}
		
		if (isHoverAnimation)
		{
			hoverAnimation = animationName;
		}
		
		else if (isClickAnimation)
		{
			clickAnimation = animationName;
		}
		
		animation.add(animationName, frameSet);
	}
}