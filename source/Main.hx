package;

import openfl.display.Sprite;

import flixel.FlxGame;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(950, 550, RoomState, 1, 24, 24, true));
	}
}