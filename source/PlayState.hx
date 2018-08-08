package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.input.keyboard.FlxKeyList;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.math.FlxPoint;
import game.Avatar;
import game.Room;

class PlayState extends FlxState
{
	private var currentRoom:Room;
	
	private static var keyDownList:FlxKeyList;
	public static var playerAvatar:Avatar;
	public static var playerNextMovement:FlxPoint;	
	override public function create():Void
	{
		super.create();
		
		playerAvatar = new Avatar("Monk");
		currentRoom = new Room("cloudInfoRoom");
		
		// FlxG.camera.follow(playerAvatar, FlxCameraFollowStyle.NO_DEAD_ZONE);
		
		currentRoom.addAvatar(playerAvatar, 150, 250);
		currentRoom.addItem("item_door1", 100, 200);
		currentRoom.addItem("item_door1", 200, 125);
		currentRoom.addItem("item_door1", 250, 175);
		
		add(currentRoom);
		add(currentRoom.walkMap);
		add(currentRoom.roomEntities);
		
		playerNextMovement = playerAvatar.getMidpoint();
	}
	
	override public function update(elapsed:Float):Void
	{
		playerAvatar.keysTriggered.North = FlxG.keys.pressed.UP && !FlxG.keys.pressed.DOWN;
		playerAvatar.keysTriggered.South = FlxG.keys.pressed.DOWN && !FlxG.keys.pressed.UP;
		playerAvatar.keysTriggered.East = FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.LEFT;
		playerAvatar.keysTriggered.West = FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT;
		playerAvatar.keysTriggered.Run = FlxG.keys.pressed.SHIFT;
		
		calculateNextDirection();
		var nextPixel:Int = currentRoom.testWalkmap(playerNextMovement.x, playerNextMovement.y);
		
		checkPath(nextPixel);
		
		trace(nextPixel);
		trace(playerNextMovement.x + ", " + playerNextMovement.y);
		
		currentRoom.sortGraphics();
		
		super.update(elapsed);
	}
	
	public function calculateNextDirection():Void
	{
		var nx:Float = playerNextMovement.x;
		var ny:Float = playerNextMovement.y;
		
		if (playerAvatar.keysTriggered.North || playerAvatar.keysTriggered.South)
		{
			if (playerAvatar.keysTriggered.East)
			{
				nx = playerAvatar.x + playerAvatar.width - 10;
				
				if (playerAvatar.keysTriggered.North)
				{
					ny = playerAvatar.y + playerAvatar.height;
				}
				
				else
				{
					ny = playerAvatar.y + playerAvatar.height;
				}
			}
			
			else if (playerAvatar.keysTriggered.West)
			{
				if (playerAvatar.keysTriggered.North)
				{
					ny = playerAvatar.y + playerAvatar.height;
				}
				
				else
				{
					ny = playerAvatar.y + playerAvatar.height;
				}
				
				nx = playerAvatar.x;
			}
			
			else if (playerAvatar.keysTriggered.North)
			{
				nx = playerAvatar.x + (playerAvatar.width / 2);
				ny = playerAvatar.y + playerAvatar.height - 10;
			}
			
			else if (playerAvatar.keysTriggered.South)
			{
				nx = playerAvatar.x + (playerAvatar.width / 2);
				ny = playerAvatar.y + playerAvatar.height;
			}
		}
		
		if (playerAvatar.keysTriggered.East)
		{
			nx = playerAvatar.x + playerAvatar.width;
			ny = playerAvatar.y + playerAvatar.height;
		}
			
		else if (playerAvatar.keysTriggered.West)
		{
			nx = playerAvatar.x;
			ny = playerAvatar.y + playerAvatar.height;
		}
		
		playerNextMovement = FlxPoint.get(nx, ny);
	}
	
	/*public function checkPath(nPoint:Int):Void	
	{
		if (FlxG.pixelPerfectOverlap(currentRoom.walkMap, playerAvatar))
		{
			trace("Collision at " + playerAvatar.x + ", " + playerAvatar.y);
		}
	}*/
	
	
	// This function not only checks the path, 
	// but allows for smooth-ish movement around certain barriers.
	
	public function checkPath(nPoint:Int):Void
	{
		if (nPoint == 0)
		{
			playerAvatar.canWalk = false;
			
			if (playerAvatar.keysTriggered.North || playerAvatar.keysTriggered.South)
			{
				if (playerAvatar.keysTriggered.South)
				{
					if (playerAvatar.keysTriggered.East)
					{
						playerAvatar.velocityX = playerAvatar.velocityX  * -1;
						playerAvatar.velocityY = 0;
					}
					
					else if (playerAvatar.keysTriggered.West)
					{
						playerAvatar.velocityX = 0;
					}
				}
				
				else
				{
					playerAvatar.velocityX = 0;
				}
				
				playerAvatar.velocityY = 0;
			}
			
			else if (playerAvatar.keysTriggered.East || playerAvatar.keysTriggered.West)
			{
				if (playerAvatar.keysTriggered.East)
				{
					playerAvatar.velocityY = playerAvatar.velocityX;
				}
				
				else
				{
					playerAvatar.velocityY = playerAvatar.velocityX * -1;
				}
				
				playerAvatar.velocityX = 0;
			}
		}
		
		else
		{
			playerAvatar.canWalk = true;
		}
	}
}