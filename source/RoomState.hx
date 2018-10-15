package;

import haxe.Json;

import openfl.Assets;
import openfl.events.ProgressEvent;
import openfl.utils.AssetLibrary;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.addons.ui.FlxUIState;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.addons.ui.FlxInputText;

import communication.NetworkManager;
import game.Avatar;
import game.Portal;
import game.Room;
import sound.SoundManager;

class RoomState extends FlxUIState
{
	public static var playerAvatar:Avatar;
	public static var currentRoom:Room;
	
	private var Northeast:Bool;
	private var Southeast:Bool;
	private var Southwest:Bool;
	private var Northwest:Bool;
	
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
		
		NetworkManager.connect("71.78.101.154", 1626);
		NetworkManager.networkSocket.addEventListener(ProgressEvent.SOCKET_DATA, handlePacket);
		
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
		
		// 1 is TRUE: Collision.
		// 0 is FALSE: No Collision.
		// Probably still have a problem with 0-pixels.
		
		rx -= playerAvatar.offset.x;
		ry -= playerAvatar.offset.y;
		
		lx -= playerAvatar.offset.x;
		ly -= playerAvatar.offset.y;
		
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
		
		if (playerAvatar.currentAction == Avatar.actionSet.Walk)
		{
			FlxG.overlap(playerAvatar, currentRoom.portalEntities, enterPortal);
			NetworkManager.sendMotion();
		}
		
		if (!playerAvatar.enableWalk)
		{
			audioManager.currentSurface = 0x0;
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
		
		playerAvatar.playerNextMovement = testNextPoints();
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
	
	public function handlePacket(e:ProgressEvent):Void
	{
		var byteCount:Int = Math.ceil(e.bytesLoaded);
		var packetString:String = NetworkManager.networkSocket.readUTFBytes(byteCount);
		var packet:Dynamic = Json.parse(packetString);
		
		switch(packet.id)
		{
			case 10:
				var handledPacket:IncomingJoinPacket = Json.parse(packetString);
				trace(handledPacket.fromRoom);
				currentRoom.addAvatar(new Avatar("Test"), handledPacket.fromRoom);
			default:
		}
	}
}