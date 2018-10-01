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
		super(10);
		//this.height = 1;
		speaker = username;
	}
	
	public function newBubble(message:String):Void
	{
		var newBubble:ChatBubble = new ChatBubble(speaker, message, 0);
		
		FlxTween.tween(newBubble, { alpha: 1 }, 0.5, { ease: FlxEase.smootherStepInOut });
		
		newBubble.x = 0;
		for (bubble in this)
		{
			FlxTween.tween(bubble, { y: bubble.y - newBubble.height }, 0.5, { ease: FlxEase.smootherStepOut });
			//bubble.y -= newBubble.height;
		}
		
		newBubble.y = -1 * newBubble.height;
		
		add(newBubble);
	}
}