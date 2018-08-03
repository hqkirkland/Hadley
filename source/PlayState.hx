package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.input.keyboard.FlxKeyList;
import flixel.FlxCamera.FlxCameraFollowStyle;
import game.Avatar;
import game.Room;

class PlayState extends FlxState
{
	private var currentRoom:Room;
	
	private static var keyDownList:FlxKeyList;
	public static var playerAvatar:Avatar;
	
	override public function create():Void
	{
		super.create();
		
		playerAvatar = new Avatar("Monk");
		currentRoom = new Room("cloudInfoRoom");
		
		// FlxG.camera.follow(playerAvatar, FlxCameraFollowStyle.NO_DEAD_ZONE);
		
		currentRoom.addAvatar(playerAvatar, 100, 250);
		currentRoom.addItem("item_door1", 100, 200);
		currentRoom.addItem("item_door1", 200, 125);
		currentRoom.addItem("item_door1", 250, 175);
		
		add(currentRoom);
		add(currentRoom.roomEntities);
	}
	
	override public function update(elapsed:Float):Void
	{
		playerAvatar.keysTriggered.North = FlxG.keys.pressed.UP && !FlxG.keys.pressed.DOWN;
		playerAvatar.keysTriggered.South = FlxG.keys.pressed.DOWN && !FlxG.keys.pressed.UP;
		playerAvatar.keysTriggered.East = FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.LEFT;
		playerAvatar.keysTriggered.West = FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT;
		playerAvatar.keysTriggered.Run = FlxG.keys.pressed.SHIFT;
		
		currentRoom.sortGraphics();
		
		super.update(elapsed);
	}
}