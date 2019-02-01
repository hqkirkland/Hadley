package;

import communication.messages.ServerExitRoomPacket;
import communication.messages.ServerRoomIdentityPacket;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.ProgressEvent;
import openfl.utils.AssetLibrary;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIState;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.input.keyboard.FlxKey;

import communication.NetworkManager;
import communication.messages.ServerPacket;
import communication.messages.ServerJoinRoomPacket;
import communication.messages.ServerMovementPacket;
import communication.messages.MessageType;
import game.Avatar;
import game.ClientData;
import game.Portal;
import game.Room;
import sound.SoundManager;

class RoomState extends FlxUIState
{
	public static var playerAvatar:Avatar;
	public static var currentRoom:Room;
	
	private static var nextRoom:String;
	private static var exitRoom:String;
	
	private static var audioManager:SoundManager;
	private static var borderArray:Array<Int> = [0xFF010101, 0x00000000];
	
	private static var roomAvatars:Map<String, Avatar>;
	
	private var tf:FlxInputText;
	
	override public function create():Void
	{
		super.create();
		FlxG.scaleMode = new FixedScaleMode();
		FlxG.autoPause = false;
		
		var setupLoader:ClientData = new ClientData();
		setupLoader.addEventListener(Event.COMPLETE, initiateConnection); 
		setupLoader.start();
		
		audioManager = new SoundManager();
	}
	
	private function initiateConnection(e:Event):Void
	{
		var rand:Int = Math.ceil(Math.random() * 1000);
		playerAvatar = new Avatar("Monk" + rand);
		playerAvatar.setAppearance("1^0^2^2^3^2^4^2^6^0^7^1^8^0^5^0");
		
		NetworkManager.connect("72.182.108.158", 4000, playerAvatar.username, "WHIRLPOOL-2018");
		NetworkManager.networkSocket.addEventListener(Event.CONNECT, doLogin);
		NetworkManager.networkSocket.addEventListener(ProgressEvent.SOCKET_DATA, receivePacket);
	}
	
	private function doLogin(e:Event):Void
	{
		NetworkManager.sendAuthenticate();
		joinRoom("cloudInfoRoom");
	}
	
	private function joinRoom(roomName:String):Void
	{
		if (currentRoom != null)
		{
			destroyRoom();
		}
		
		roomAvatars = new Map<String, Avatar>();
		roomAvatars.set(playerAvatar.username, playerAvatar);
		
		nextRoom = "";
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
		
		#if flash
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
		#end
		
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
		#if flash
		remove(tf);
		#end
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
		
		if (currentRoom == null)
		{
			return;
		}
		
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
		
		// Player was walking, but now has stopped.
		
		if (playerAvatar.currentAction == Avatar.actionSet.Stand && playerAvatar.previousAction == Avatar.actionSet.Walk)
		{
			// So stop the movement.
			NetworkManager.sendMotion(false,
									  false,
									  false,
									  false,
									  false,
									  playerAvatar.x,
									  playerAvatar.y);
		}
		
		else if (checkMovementChange())
		{
			NetworkManager.sendMotion(playerAvatar.keysTriggered.North, 
									  playerAvatar.keysTriggered.South, 
									  playerAvatar.keysTriggered.East, 
									  playerAvatar.keysTriggered.West,
									  playerAvatar.keysTriggered.Run,
									  playerAvatar.x,
									  playerAvatar.y);
		}
		
		if (playerAvatar.currentAction == Avatar.actionSet.Walk)
		{
			FlxG.overlap(playerAvatar, currentRoom.portalEntities, enterPortal);
		}
		

		
		/*if (playerAvatar.currentAction != playerAvatar.previousAction)
		{
			if (playerAvatar.currentAction == Avatar.actionSet.Stand)
			{
				NetworkManager.sendMotion(false, false, false, false, false, playerAvatar.x, playerAvatar.y);
			}
		}*/
		
		playerAvatar.playerNextMovement = testNextPoints(playerAvatar);
		
		if (!playerAvatar.enableWalk)
		{
			audioManager.currentSurface = 0x0;
		}
		
		playerAvatar.smoothMovement();
		
		audioManager.playWalkSound(playerAvatar.keysTriggered.Run);
	}
	
	private function speakUp(message:String, action:String):Void
	{
		if (action == "enter")
		{
			playerAvatar.chatGroup.newBubble(message);
			#if flash
			tf.text = "";
			#end
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
		var serverPacket:ServerPacket = NetworkManager.handlePacket(byteCount);

		if (!roomAvatars.exists(serverPacket.senderId))
		{
			if (serverPacket.messageId != MessageType.JoinRoom && serverPacket.messageId != MessageType.RoomIdentity)
			{
				trace(serverPacket.senderId + ":<Avatar> was not found.");
				return;
			}
		}
		
		switch (serverPacket.messageId)
		{
			case MessageType.JoinRoom:
				var joinPacket:ServerJoinRoomPacket = cast(serverPacket, ServerJoinRoomPacket);
				
				roomAvatars.set(joinPacket.senderId, new Avatar(joinPacket.senderId));
				roomAvatars[joinPacket.senderId].setAppearance(joinPacket.appearance);
				
				currentRoom.addAvatar(roomAvatars[joinPacket.senderId], joinPacket.fromRoom);
				
			case MessageType.Movement:
				var movePacket:ServerMovementPacket = cast(serverPacket, ServerMovementPacket);
				
				roomAvatars[movePacket.senderId].keysTriggered.North = movePacket.north;
				roomAvatars[movePacket.senderId].keysTriggered.South = movePacket.south;
				roomAvatars[movePacket.senderId].keysTriggered.East = movePacket.east;
				roomAvatars[movePacket.senderId].keysTriggered.West = movePacket.west;
				roomAvatars[movePacket.senderId].keysTriggered.Run = movePacket.run;
				
				roomAvatars[movePacket.senderId].playerNextMovement = FlxPoint.get(0, 0);
				roomAvatars[movePacket.senderId].smoothMovement();
				
				if (roomAvatars[movePacket.senderId].currentAction == Avatar.actionSet.Stand)
				{
					
					roomAvatars[movePacket.senderId].x = movePacket.x;
					roomAvatars[movePacket.senderId].y = movePacket.y;
					
				}
				
			case MessageType.RoomIdentity:
				var identityPacket:ServerRoomIdentityPacket = cast(serverPacket, ServerRoomIdentityPacket);
				roomAvatars.set(identityPacket.senderId, new Avatar(identityPacket.senderId));
				roomAvatars[identityPacket.senderId].setAppearance(identityPacket.appearance);
				
				currentRoom.addAvatar(roomAvatars[identityPacket.senderId], "");
				
				if (identityPacket.x != 0 && identityPacket.y != 0)
				{
					roomAvatars[identityPacket.senderId].x = identityPacket.x;
					roomAvatars[identityPacket.senderId].y = identityPacket.y;
				}
			
			case MessageType.ExitRoom:
				var exitPacket:ServerExitRoomPacket = cast(serverPacket, ServerExitRoomPacket);
				roomAvatars[exitPacket.senderId].leaveRoom();
				roomAvatars.remove(exitPacket.senderId);
				
			default:
				return;
		}
	}
	
	public function checkMovementChange():Bool
	{
		if (FlxG.keys.anyJustPressed([UP, DOWN, LEFT, RIGHT]))
		{
			return true;
		}
		
		if (FlxG.keys.anyJustReleased([UP, DOWN, LEFT, RIGHT]))
		{
			return true;
		}
		
		return false;
		
		/*
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
		*/
		
		return false;
	}
}