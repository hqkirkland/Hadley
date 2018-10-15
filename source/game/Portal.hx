package game;

import flixel.FlxSprite;

import openfl.display.BitmapData;

/**
 * ...
 * @author Hunter
 */
class Portal extends FlxSprite
{
	public var nextRoom:String;
	public var startDirection:String;
	public var exitDirections:Array<String>;
	public var isDefault:Bool = false;
	public var enabled:Bool = true;
	public var setX:Int;
	public var setY:Int;
	
	public function new(portalMask:BitmapData, _startDirection:String, _exitDirections:Array<String>, _nextRoom:String, _setX:Int=0, _setY:Int=0, ?x:Int = 0, ?y:Int = 0) 
	{
		super(x, y);
		
		nextRoom = _nextRoom;
		this.pixels = portalMask;
		
		startDirection = _startDirection;
		exitDirections = _exitDirections;
		nextRoom = _nextRoom;
		setX = _setX;
		setY = _setY;
	}
	
	public function checkDirection(directionString:String):Bool
	{
		return (exitDirections.indexOf(directionString) != -1);
	}
}