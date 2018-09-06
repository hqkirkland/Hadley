package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.input.keyboard.FlxKeyList;
import flixel.math.FlxPoint;
import openfl.Assets;
import openfl.utils.AssetLibrary;
// import openfl.utils.AssetType;

import game.Avatar;
import game.Room;
import sound.SoundManager;

class RoomState extends FlxState
{
	public static var playerAvatar:Avatar;
	public static var currentRoom:Room;
	public static var playerNextMovement:FlxPoint;
	
	private var Northeast:Bool;
	private var Southeast:Bool;
	private var Southwest:Bool;
	private var Northwest:Bool;
	
	private static var keyDownList:FlxKeyList;
	private static var audioManager:SoundManager;
	private static var borderArray:Array<Int> = [0xFF010101, 0x00000000];
	private static var progress:Int = 0;
	
	override public function create():Void
	{
		super.create();
		
		playerAvatar = new Avatar("Monk");
		audioManager = new SoundManager();

		#if html5
		FlxG.debugger.visible = true;
		FlxG.log.redirectTraces = true;
		#end

		joinRoom("cloudInfoRoom");
	}

	private function joinRoom(roomName:String)
	{
		if (currentRoom != null)
		{
			destroyRoom();
		}
		
		currentRoom = new Room(roomName);
		// TODO: onProgress() handler
		Assets.loadLibrary(roomName).onComplete(loadRoom);
	}
	
	private function loadRoom(completeLib:AssetLibrary):Void
	{
		Assets.registerLibrary(currentRoom.roomName, completeLib);

		var roomStructure:String = Assets.getText(currentRoom.roomName + ":assets/" + currentRoom.roomName + "/RoomObjects.json");
		currentRoom.generateRoom(roomStructure);
		
		currentRoom.addAvatar(playerAvatar, 250, 250);
		
		add(currentRoom);
		add(currentRoom.roomEntities);
	}
	
	private function destroyRoom():Void
	{
		remove(currentRoom.roomEntities);
		remove(currentRoom);
		Assets.unloadLibrary(currentRoom.roomName);
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
				
				lx = playerAvatar.x + 35;
				ly = playerAvatar.y + 62;
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

		audioManager.currentSurface = currentRoom.testWalkmap(rx, ry);

		// 1 is TRUE: Collision.
		// 0 is FALSE: No Collision.
		// Probably still have a problem with 0-pixels.
		var ptR:Float = if (borderArray.indexOf(currentRoom.testWalkmap(rx, ry)) != -1) 1 else 0;
		var ptL:Float = if (borderArray.indexOf(currentRoom.testWalkmap(rx, ry)) != -1) 1 else 0;
		
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
				playerAvatar.x -= 3;
			}
			
			else if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				playerAvatar.x += 3;
			}
		}
		
		else if (Southwest)
		{			
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				playerAvatar.x += 2;
			}
			
			else if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				playerAvatar.x -= 3;
			}
		}
		
		else if (Southeast)
		{			
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				playerAvatar.x += 2;
			}
			
			else if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				playerAvatar.x -= 3;
			}
		}
		
		else if (Northwest)
		{			
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				playerAvatar.x -= 1;
			}
			
			else if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityX = 0;
				playerAvatar.velocity.set(0, playerAvatar.velocityY);
				playerAvatar.x += 3;
			}
		}
		
		else if (playerAvatar.keysTriggered.East)
		{			
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityY = 0;
			}
			
			if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityY = 0;
			}
		}
		
		else if (playerAvatar.keysTriggered.West)
		{
			if (playerNextMovement.x == 1)
			{
				playerAvatar.velocityY = 0;
			}
			
			if (playerNextMovement.y == 1)
			{
				playerAvatar.velocityY = 0;
			}
		}
	}
	
	// Private function enter door:
	// this.active = false;
	// FlxG.switchTo(LoadState)
	
	override public function update(elapsed:Float):Void
	{
		if (!currentRoom.roomReady)
		{
			return;
		}

		// TODO: If in room//if in context..
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
		audioManager.playWalkSound(playerAvatar.keysTriggered.Run);
		
		// Should this call be made in Room's update loop instead?
		currentRoom.sortGraphics();
		
		super.update(elapsed);
	}
}