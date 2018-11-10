package game;

import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

import game.ChatBubble;

/**
 * ...
 * @author Hunter
 */
class BubbleStack extends FlxTypedSpriteGroup<ChatBubble>
{
	private var speaker:String;
	
	public function new(username:String) 
	{
		super(5);
		//this.height = 1;
		speaker = username;
	}
	
	public function newBubble(message:String):Void
	{
		var newBubble:ChatBubble = new ChatBubble(speaker, message, 0);
		newBubble.x = 0;
		
		var i:Int = 0;
		
		FlxTween.tween(newBubble, { alpha: 1 }, 0.5, { ease: FlxEase.smootherStepInOut });
		FlxTween.tween(newBubble, { alpha: 0 }, 0.5, { ease: FlxEase.smoothStepOut, startDelay: 5, onComplete: {
			function(_) 
			{
				//this.remove(newBubble);
				newBubble.destroy();
			}
		}});
		
		
		for (bubble in this)
		{			
			FlxTween.tween(bubble, { y: bubble.y - newBubble.height }, 0.5, { ease: FlxEase.smootherStepOut });
			i++;
		}
		
		newBubble.y = -1 * newBubble.height;
		
		add(newBubble);
	}
}