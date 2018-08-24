package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.input.keyboard.FlxKeyList;
import flixel.math.FlxPoint;
import game.Avatar;
import game.Room;

class PlayState extends FlxState
{
	private var currentRoom:Room;
	
	private static var keyDownList:FlxKeyList;
	public static var playerAvatar:Avatar;
	public static var playerNextMovement:FlxPoint;
	
	private var Northeast:Bool;
	private var Southeast:Bool;
	private var Southwest:Bool;
	private var Northwest:Bool;
	
	override public function create():Void
	{
		super.create();
		
		playerAvatar = new Avatar("Monk");
		currentRoom = new Room("cloudInfoRoom");
		
		// FlxG.camera.follow(playerAvatar, FlxCameraFollowStyle.NO_DEAD_ZONE);
		// FlxG.debugger.visible = true;
		
		currentRoom.addAvatar(playerAvatar, 150, 250);
		currentRoom.addItem("item_door1", 125, 210);
		//currentRoom.addItem("item_statue", 260, 200);
		
		add(currentRoom);
		//add(currentRoom.walkMap);
		add(currentRoom.roomEntities);
		
		FlxG.log.redirectTraces = true;
	}
	
	private function testNextPoints():FlxPoint
	{
		var rx:Float = 0;
		var ry:Float = 0;
		
		var lx:Float = 0;
		var ly:Float = 0;
		
		if (playerAvatar.keysTriggered.North)
		{
			if (Northeast)
			{
				// Represents right foot.
				rx = playerAvatar.x + 33;
				ry = playerAvatar.y + 60;
				
				// Represents left foot.
				lx = playerAvatar.x + 20;
				ly = playerAvatar.y + 57;
			}
			
			else if (Northwest)
			{
				rx = playerAvatar.x + 20;
				ry = playerAvatar.y + 57;
				
				lx = playerAvatar.x + 7;
				ly = playerAvatar.y + 60;
			}
			
			else
			{
				rx = playerAvatar.x + 30;
				ry = playerAvatar.y + 55;
				
				lx = playerAvatar.x + 10;
				ly = playerAvatar.y + 55;
			}
		}
		
		if (playerAvatar.keysTriggered.South)
		{
			if (Southeast)
			{
				rx = playerAvatar.x + 17;
				ry = playerAvatar.y + 69;
				
				lx = playerAvatar.x + 28;
				ly = playerAvatar.y + 65;
			}
			
			else if (Southwest)
			{
				rx = playerAvatar.x + 10;
				ry = playerAvatar.y + 65;
				
				lx = playerAvatar.x + 20;
				ly = playerAvatar.y + 65;
			}
			
			else
			{
				rx = playerAvatar.x + 10;
				ry = playerAvatar.y + 70;
				
				lx = playerAvatar.x + 30;
				ly = playerAvatar.y + 70;
			}
		}
		
		if (playerAvatar.keysTriggered.East)
		{
			if (!Southeast && !Northeast)
			{
				rx = playerAvatar.x + 26;
				ry = playerAvatar.y + 63;
				
				lx = playerAvatar.x + 26;
				ly = playerAvatar.y + 58;
			}
		}
		
		if (playerAvatar.keysTriggered.West)
		{
			if (!Southwest && !Northwest)
			{
				rx = playerAvatar.x + 10;
				ry = playerAvatar.y + 58;
				
				lx = playerAvatar.x + 10;
				ly = playerAvatar.y + 65;
			}
		}
		
		var a:Int = currentRoom.testWalkmap(rx, ry);
		var b:Int = currentRoom.testWalkmap(lx, ly);
		
		var ptR:Float = (currentRoom.testWalkmap(rx, ry) / 65793) % 255;
		var ptL:Float = (currentRoom.testWalkmap(lx, ly) / 65793) % 255;
		
		//trace("Point A (R): " + ptR);
		//trace("Point B (L): " + ptL);
		
		return FlxPoint.get(ptR, ptL);
	}
	
	private function smoothMovement():Void
	{
		// X is R
		// Y is L
		// South means SWITCH SHIFTS of L and R.
		
		if (playerNextMovement.x == 1 && playerNextMovement.y == 1)
		{
			playerAvatar.velocityX = 0;
			playerAvatar.velocityY = 0;
			playerAvatar.velocity.set(0, 0);
			playerAvatar.canWalk = false;
			return;
		}
		
		playerAvatar.canWalk = true;
		
		if (Northeast)
		{			
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				trace("Right foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.x -= 3;
			}
			
			else if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				trace("Left foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.x += 3;
			}
		}
		
		else if (Southwest)
		{			
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				trace("Right foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.x += 2;
			}
			
			else if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				trace("Left foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.x -= 3;
			}
		}
		
		else if (Southeast)
		{			
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				trace("Right foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.x += 2;
			}
			
			else if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				trace("Left foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);				
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.x -= 3;
			}
		}
		
		else if (Northwest)
		{			
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityX = 0;
				//playerAvatar.velocity.set(0, playerAvatar.velocityY);
				trace("Right foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.x -= 1;
			}
			
			else if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityX = 0;
				//playerAvatar.velocity.set(0, playerAvatar.velocityY);
				trace("Left foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);				
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.x += 3;
			}
		}
		
		else if (playerAvatar.keysTriggered.East)
		{			
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityY = 0;
				trace("Left foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);				
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.y -= 1;
			}
			
			if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityY = 0;
				trace("Left foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);				
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.y += 1;
			}
		}
		
		else if (playerAvatar.keysTriggered.West)
		{
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityY = 0;
				trace("Left foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);				
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.y += 1;
			}
			
			if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityY = 0;
				trace("Left foot hit!");
				trace("Velocity X: " + playerAvatar.velocityX);				
				trace("Velocity Y: " + playerAvatar.velocityY);
				playerAvatar.y -= 1;
			}
		}
	}
	
	override public function update(elapsed:Float):Void
	{
		playerAvatar.keysTriggered.North = FlxG.keys.pressed.UP && !FlxG.keys.pressed.DOWN;
		playerAvatar.keysTriggered.South = FlxG.keys.pressed.DOWN && !FlxG.keys.pressed.UP;
		playerAvatar.keysTriggered.East = FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.LEFT;
		playerAvatar.keysTriggered.West = FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT;
		playerAvatar.keysTriggered.Run = FlxG.keys.pressed.SHIFT;
		
		this.Northeast = playerAvatar.keysTriggered.North && playerAvatar.keysTriggered.East;
		this.Southeast = playerAvatar.keysTriggered.South && playerAvatar.keysTriggered.East;
		this.Southwest = playerAvatar.keysTriggered.South && playerAvatar.keysTriggered.West;
		this.Northwest = playerAvatar.keysTriggered.North && playerAvatar.keysTriggered.West;
		
		playerNextMovement = testNextPoints();
		smoothMovement();
		
		currentRoom.sortGraphics();
		super.update(elapsed);
	}
}