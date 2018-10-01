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
	
	private static var MAX_WIDTH:Int = ChatBubble.MAX_LINE + 30;
	
	public function new(username:String) 
	{
		super(10);
		//this.height = 1;
		speaker = username;
	}
	
	public function newBubble(message:String):Void
	{
		this.width = MAX_WIDTH;
		var newBubble:ChatBubble = new ChatBubble(speaker, message, 0);
		var i:Int = 0;
		
		FlxTween.tween(newBubble, { alpha: 1 }, 0.5, { ease: FlxEase.smootherStepInOut });
		
		trace("Group Width: " + this.width);
		trace("Group X: " + this.x);
		trace("Bubble Width: " + newBubble.width);
		trace("Calculated X: " + Math.floor(((MAX_WIDTH / 2) - (newBubble.width / 2))));
		trace("");
		
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