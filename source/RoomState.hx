package;

import communication.messages.ServerMotionPacket;
import haxe.Json;

import openfl.Assets;
import openfl.events.ProgressEvent;
import openfl.utils.AssetLibrary;
import openfl.utils.ByteArray;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIState;
import flixel.system.scaleModes.FixedScaleMode;

import communication.NetworkManager;
import communication.messages.Packet;
import communication.messages.MessageType;
import communication.messages.ServerJoinPacket;
import game.Avatar;
import game.Portal;
import game.Room;
import sound.SoundManager;

class RoomState extends FlxUIState
{
	public static var playerAvatar:Avatar;
	public static var currentRoom:Room;
	
	private var playerAvatar2:Avatar;
	
	private var nextRoom:String;
	private var exitRoom:String;
	
	private static var audioManager:SoundManager;
	private static var borderArray:Array<Int> = [0xFF010101, 0x00000000];
	
	private var tf:FlxInputText;
	
	override public function create():Void
	{
		super.create(); 
		FlxG.scaleMode = new FixedScaleMode();
		FlxG.autoPause = false;
		
		playerAvatar = new Avatar("Monk");
		audioManager = new SoundManager();
		
		NetworkManager.connect("72.182.108.158", 1626);
		NetworkManager.networkSocket.addEventListener(ProgressEvent.SOCKET_DATA, receivePacket);
		
		joinRoom("cloudInfoRoom");
	}
	
	private function joinRoom(roomName:String)
	{
		if (currentRoom != null)
		{
			destroyRoom();
		}
		
		this.nextRoom = "";
		currentRoom = new Room(roomName);
		
		Assets.loadLibrary(roomName).onComplete(loadRoom);
	}
	
	private function loadRoom(completeLib:AssetLibrary):Void
	{
		Assets.registerLibrary(currentRoom.roomName, completeLib);
		
		var roomStructure:String = Assets.getText(currentRoom.roomName + ":assets/" + currentRoom.roomName + "/" + currentRoom.roomName + "_Objects.json");
		currentRoom.generateRoom(roomStructure);
		
		currentRoom.addAvatar(playerAvatar, exitRoom);
		exitRoom = "";
		
		add(currentRoom);
		add(currentRoom.vehicleEntities);
		add(currentRoom.roomEntities);
		add(currentRoom.portalEntities);
		add(playerAvatar.chatGroup);
		
		tf = new FlxInputText(50, 100, 300);
		tf.borderColor = 0xFFFFFFFF;
		tf.x = 150;
		tf.y = 400;
		tf.width = 300;
		tf.height = 15;
		tf.caretWidth = 5;
		tf.callback = speakUp;
		tf.text = "";
		add(tf);
		
		setupCamera();
		
		this.bgColor = currentRoom.backgroundColor;
		currentRoom.portalEntities.visible = false;
		
		NetworkManager.sendJoinRoom(currentRoom.roomName);
	}
	
	private function setupCamera():Void
	{
		var ROOM_MIN_X:Float;
		var ROOM_MAX_X:Float;
		var ROOM_MIN_Y:Float;
		var ROOM_MAX_Y:Float;
		
		if (currentRoom.width < FlxG.width)
		{
			ROOM_MIN_X = 0;
			ROOM_MAX_X = (FlxG.width / 2) + (currentRoom.width / 2);
		}
		
		else
		{
			ROOM_MIN_X = currentRoom.x;
			ROOM_MAX_X = currentRoom.width;
		}
		
		if (currentRoom.height < FlxG.height)
		{
			ROOM_MIN_Y = 0;
			ROOM_MAX_Y = (FlxG.height / 2) + (currentRoom.height / 2);
		}
		
		else
		{
			ROOM_MIN_Y = currentRoom.y;
			ROOM_MAX_Y = currentRoom.height;
		}
		
		FlxG.camera.setScrollBoundsRect(ROOM_MIN_X, ROOM_MIN_Y, ROOM_MAX_X, ROOM_MAX_Y);
		FlxG.camera.follow(playerAvatar, FlxCameraFollowStyle.LOCKON, .25);
		
		FlxG.camera.deadzone = new FlxRect(FlxG.camera.deadzone.x, FlxG.camera.deadzone.y, FlxG.camera.deadzone.width, FlxG.camera.deadzone.height / 2);
	}
	
	private function destroyRoom():Void
	{
		// remove(currentRoom.walkMap);
		remove(currentRoom.portalEntities);
		remove(currentRoom.roomEntities);
		remove(currentRoom.vehicleEntities);
		remove(currentRoom);
		remove(tf);
	}
	
	private function testNextPoints(testAvatar:Avatar):FlxPoint
	{
		var Northeast:Bool = testAvatar.keysTriggered.North && testAvatar.keysTriggered.East;
		var Northwest:Bool = testAvatar.keysTriggered.North && testAvatar.keysTriggered.West;
		var Southeast:Bool = testAvatar.keysTriggered.South && testAvatar.keysTriggered.East;
		var Southwest:Bool = testAvatar.keysTriggered.South && testAvatar.keysTriggered.West;
		
		var rx:Float = 0;
		var ry:Float = 0;
		
		var lx:Float = 0;
		var ly:Float = 0;
		
		if (testAvatar.keysTriggered.North)
		{
			if (Northeast)
			{
				// Represents right foot.
				rx = testAvatar.x + 33;
				ry = testAvatar.y + 60;
				
				// Represents left foot.
				lx = testAvatar.x + 20;
				ly = testAvatar.y + 57;
			}
			
			else if (Northwest)
			{
				rx = testAvatar.x + 20;
				ry = testAvatar.y + 57;
				
				lx = testAvatar.x + 7;
				ly = testAvatar.y + 60;
			}
			
			else
			{
				rx = testAvatar.x + 30;
				ry = testAvatar.y + 55;
				
				lx = testAvatar.x + 10;
				ly = testAvatar.y + 55;
			}
		}
		
		if (testAvatar.keysTriggered.South)
		{
			if (Southeast)
			{
				rx = testAvatar.x + 17;
				ry = testAvatar.y + 69;
				
				lx = testAvatar.x + 35;
				ly = testAvatar.y + 62;
			}
			
			else if (Southwest)
			{
				rx = testAvatar.x + 10;
				ry = testAvatar.y + 65;
				
				lx = testAvatar.x + 20;
				ly = testAvatar.y + 65;
			}
			
			else
			{
				rx = testAvatar.x + 10;
				ry = testAvatar.y + 70;
				
				lx = testAvatar.x + 30;
				ly = testAvatar.y + 70;
			}
		}
		
		if (testAvatar.keysTriggered.East)
		{
			if (!Southeast && !Northeast)
			{
				rx = testAvatar.x + 26;
				ry = testAvatar.y + 63;
				
				lx = testAvatar.x + 26;
				ly = testAvatar.y + 58;
			}
		}
		
		if (testAvatar.keysTriggered.West)
		{
			if (!Southwest && !Northwest)
			{
				rx = testAvatar.x + 10;
				ry = testAvatar.y + 58;
				
				lx = testAvatar.x + 10;
				ly = testAvatar.y + 65;
			}
		}
		
		// 1 is TRUE: Collision.
		// 0 is FALSE: No Collision.
		// Probably still have a problem with 0-pixels.
		
		rx -= testAvatar.offset.x;
		ry -= testAvatar.offset.y;
		
		lx -= testAvatar.offset.x;
		ly -= testAvatar.offset.y;
		
		var ptR:Float = if (borderArray.indexOf(currentRoom.testWalkmap(rx, ry)) != -1) 1 else 0;
		var ptL:Float = if (borderArray.indexOf(currentRoom.testWalkmap(lx, ly)) != -1) 1 else 0;
		
		audioManager.currentSurface = currentRoom.testWalkmap(rx, ry);
		
		return FlxPoint.get(ptR, ptL);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (!currentRoom.roomReady)
		{
			return;
		}
		
		if (nextRoom != "" && playerAvatar.fadeComplete)
		{
			destroyRoom();
			joinRoom(nextRoom);
		}
		
		// TODO: If in room//if in context..
		playerAvatar.keysTriggered.North = FlxG.keys.pressed.UP && !FlxG.keys.pressed.DOWN;
		playerAvatar.keysTriggered.South = FlxG.keys.pressed.DOWN && !FlxG.keys.pressed.UP;
		playerAvatar.keysTriggered.East = FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.LEFT;
		playerAvatar.keysTriggered.West = FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT;
		playerAvatar.keysTriggered.Run = FlxG.keys.pressed.SHIFT;
		
		if (playerAvatar.currentAction == Avatar.actionSet.Walk)
		{
			FlxG.overlap(playerAvatar, currentRoom.portalEntities, enterPortal);
			var motionChanged:Bool = checkMovementChange();
			
			if (motionChanged)
			{
				NetworkManager.sendMotion(playerAvatar.keysTriggered.North, 
										  playerAvatar.keysTriggered.South, 
										  playerAvatar.keysTriggered.East, 
										  playerAvatar.keysTriggered.West,
										  playerAvatar.keysTriggered.Run);
			}
		}
		
		if (!playerAvatar.enableWalk)
		{
			audioManager.currentSurface = 0x0;
		}
		
		playerAvatar.playerNextMovement = testNextPoints(playerAvatar);
		playerAvatar.smoothMovement();
		
		audioManager.playWalkSound(playerAvatar.keysTriggered.run);
	}
	
	private function speakUp(message:String, action:String):Void
	{
		if (action == "enter")
		{
			playerAvatar.chatGroup.newBubble(message);
			tf.text = "";
		}
	}
	
	public function enterPortal(objectA:FlxObject, objectB:FlxObject):Void
	{
		if (objectA == playerAvatar)
		{
			if (cast(objectB, Portal).checkDirection(playerAvatar.currentDirection))
			{
				if (cast(objectB, Portal).enabled)
				{
					if (FlxG.pixelPerfectOverlap(playerAvatar, cast(objectB, Portal)))
					{
						nextRoom = cast(objectB, Portal).nextRoom;
						exitRoom = currentRoom.roomName;
						playerAvatar.leaveRoom();
					}
				}
			}
		}
		
		else if (objectB == playerAvatar)
		{
			if (cast(objectA, Portal).checkDirection(playerAvatar.currentDirection))
			{
				if (cast(objectA, Portal).enabled)
				{
					if (FlxG.pixelPerfectOverlap(playerAvatar, cast(objectA, Portal)))
					{
						nextRoom = cast(objectA, Portal).nextRoom;
						exitRoom = currentRoom.roomName;
						playerAvatar.leaveRoom();
					}
				}
			}
		}
	}
	
	public function receivePacket(e:ProgressEvent):Void
	{
		var byteCount:Int = Math.ceil(e.bytesLoaded);
		var serverPacket:Packet = NetworkManager.handlePacket(byteCount);
		
		switch (serverPacket.messageId)
		{
			case MessageType.JoinRoom:
				var joinPacket:ServerJoinPacket = cast(serverPacket, ServerJoinPacket);
				playerAvatar2 = new Avatar("Monk2");
				currentRoom.addAvatar(playerAvatar2, joinPacket.fromRoom);
			case MessageType.Motion:
				var motionPacket:ServerMotionPacket = cast(serverPacket, ServerMotionPacket);
				playerAvatar2.keysTriggered.North = motionPacket.north;
				playerAvatar2.keysTriggered.South = motionPacket.south;
				playerAvatar2.keysTriggered.East = motionPacket.east;
				playerAvatar2.keysTriggered.West = motionPacket.west;
				playerAvatar2.keysTriggered.Run = motionPacket.run;
				
				playerAvatar2.playerNextMovement = testNextPoints(playerAvatar2);
				playerAvatar2.smoothMovement();
				
			default:
				return;
		}
	}
	
	public function checkMovementChange():Bool
	{
		if (playerAvatar.keysTriggered.North != playerAvatar.previousKeysTriggered.North)
		{
			return true;
		}
		
		if (playerAvatar.keysTriggered.South != playerAvatar.previousKeysTriggered.South)
		{
			return true;
		}
		
		if (playerAvatar.keysTriggered.East != playerAvatar.previousKeysTriggered.East)
		{
			return true;
		}
		
		if (playerAvatar.keysTriggered.West != playerAvatar.previousKeysTriggered.West)
		{
			return true;
		}
		
		if (playerAvatar.keysTriggered.Run != playerAvatar.previousKeysTriggered.Run)
		{
			return true;
		}
		
		return false;
	}
}