package;

import communication.NetworkManager;
import communication.messages.ServerPacket;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.plugin.FlxMouseControl;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.util.FlxColor;
import game.Avatar;
import game.ClientData;
import game.Portal;
import game.Room;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.ProgressEvent;
import openfl.utils.AssetLibrary;
import sound.SoundManager;
import ui.StarboardInterface;

class RoomState extends FlxState
{
	public var username:String;

	public static var roomAvatars:Map<String, Avatar>;
	public static var playerAvatar:Avatar;
	public static var currentRoom:Room;
	public static var starboard:StarboardInterface;
	public static var gameCamera:FlxCamera;
	public static var starboardCamera:FlxCamera;

	private static var nextRoom:String;
	private static var exitRoom:String;
	private static var audioManager:SoundManager;
	private static var borderArray:Array<Int> = [0xFF010101, 0x00000000];
	private static var gameTicket:String;

	override public function new(_gameTicket:String)
	{
		super();
		gameTicket = _gameTicket;
	}

	override public function create():Void
	{
		super.create();

		FlxG.scaleMode = new FixedScaleMode();

		FlxG.autoPause = false;
		FlxG.sound.muteKeys = null;
		FlxG.sound.volumeDownKeys = null;
		FlxG.sound.volumeUpKeys = null;

		FlxG.debugger.drawDebug = true;
		FlxG.watch.add(FlxG, "worldBounds");

		starboard = new StarboardInterface();

		var setupLoader:ClientData = new ClientData();
		setupLoader.addEventListener(Event.COMPLETE, initiateConnection);
		setupLoader.start();

		audioManager = new SoundManager();
	}

	private function initiateConnection(e:Event):Void
	{
		var rand:Int = Math.ceil(Math.random() * 1000);
		playerAvatar = new Avatar(username);
		playerAvatar.drawFrame(true);

		NetworkManager.connect("whirlpool.nodebay.com", 8443, playerAvatar.username);
		NetworkManager.networkSocket.addEventListener(Event.CONNECT, doLogin);
		NetworkManager.networkSocket.addEventListener(ProgressEvent.SOCKET_DATA, receivePacket);
	}

	private function doLogin(e:Event):Void
	{
		NetworkManager.sendAuthenticate(gameTicket);
		RoomState.starboard.changeAppearance("67^0^44^2^34^2^24^2^94^0^72^1^51^0^61^0");
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

		starboardCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
		starboardCamera.bgColor = FlxColor.TRANSPARENT;

		setupGameCamera();

		FlxG.cameras.reset(gameCamera);
		// FlxG.cameras.add(starboardCamera);

		starboard.scrollFactor.set(0, 0);

		currentRoom.cameras = [gameCamera];

		add(currentRoom);
		trace("currentRoom: " + currentRoom.x + ", " + currentRoom.y);
		add(currentRoom.vehicleEntities);
		add(currentRoom.roomEntities);
		add(currentRoom.portalEntities);
		// add(currentRoom.walkMap);
		add(playerAvatar.chatGroup);
		add(starboard);

		starboard.gameBar.chatBox.textInput.addEventListener(KeyboardEvent.KEY_DOWN, chatBarEnter);

		FlxG.watch.addMouse();
		/*
			var uiCam:FlxCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			FlxG.cameras.add(uiCam);
			starboard.cameras = [uiCam];
		 */

		this.bgColor = currentRoom.backgroundColor;
		currentRoom.portalEntities.visible = false;
		NetworkManager.sendJoinRoom(currentRoom.roomName);
	}

	private function setupGameCamera():Void
	{
		var ROOM_MIN_X:Float;
		var ROOM_MAX_X:Float;
		var ROOM_MIN_Y:Float;
		var ROOM_MAX_Y:Float;

		if (currentRoom.width < FlxG.width)
		{
			ROOM_MIN_X = (FlxG.width / 2) - (currentRoom.width / 2);
			ROOM_MAX_X = currentRoom.width;
		}
		else
		{
			ROOM_MIN_X = currentRoom.x;
			ROOM_MAX_X = currentRoom.width;
		}

		if (currentRoom.height < FlxG.height)
		{
			ROOM_MIN_Y = (FlxG.height / 2) - (currentRoom.height / 2);
			ROOM_MAX_Y = currentRoom.height;
		}
		else
		{
			ROOM_MIN_Y = currentRoom.y;
			ROOM_MAX_Y = currentRoom.height;
		}

		gameCamera = new FlxCamera(Std.int(ROOM_MIN_X), Std.int(ROOM_MIN_Y), Std.int(ROOM_MAX_X), Std.int(ROOM_MAX_Y));
		gameCamera.setScrollBoundsRect(0, 0, currentRoom.width, currentRoom.height, true);
		gameCamera.follow(playerAvatar, FlxCameraFollowStyle.LOCKON, .25);
	}

	private function destroyRoom():Void
	{
		remove(starboard);
		remove(currentRoom.portalEntities);
		remove(currentRoom.roomEntities);
		remove(currentRoom.vehicleEntities);
		remove(currentRoom);
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
		var offsetX:Int = 15;
		var offsetY:Int = 63;

		rx -= offsetX;
		ry -= offsetY;

		lx -= offsetX;
		ly -= offsetY;

		var ptR:Float = if (borderArray.indexOf(currentRoom.testWalkmap(rx, ry)) != -1) 1 else 0;
		var ptL:Float = if (borderArray.indexOf(currentRoom.testWalkmap(lx, ly)) != -1) 1 else 0;

		audioManager.currentSurface = currentRoom.testWalkmap(rx, ry);

		return FlxPoint.get(ptR, ptL);
	}

	// TODO: Implement reactor model with keychecks instead of packets.
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

		/*
			var mouseCameraPoint:FlxPoint = FlxG.mouse.getPositionInCameraView();
			trace("mouseCameraPoint: " + mouseCameraPoint.x + ", " + mouseCameraPoint.y);

			var mousePoint:FlxPoint = FlxG.mouse.getWorldPosition();
			trace("mousePoint: " + mousePoint.x + ", " + mousePoint.y);
		 */

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
			NetworkManager.sendMotion(false, false, false, false, false, playerAvatar.x, playerAvatar.y);
		}
		else if (checkMovementChange())
		{
			NetworkManager.sendMotion(playerAvatar.keysTriggered.North, playerAvatar.keysTriggered.South, playerAvatar.keysTriggered.East,
				playerAvatar.keysTriggered.West, playerAvatar.keysTriggered.Run, playerAvatar.x, playerAvatar.y);
		}

		if (playerAvatar.currentAction == Avatar.actionSet.Walk)
		{
			FlxG.overlap(playerAvatar, currentRoom.portalEntities, enterPortal);
		}

		playerAvatar.playerNextMovement = testNextPoints(playerAvatar);

		if (!playerAvatar.enableWalk)
		{
			audioManager.currentSurface = 0x0;
		}

		playerAvatar.smoothMovement();
		audioManager.playWalkSound(playerAvatar.keysTriggered.Run);
	}

	private function chatBarEnter(e:KeyboardEvent)
	{
		if (e.keyCode == 13)
		{
			var messageText:String = starboard.gameBar.chatBox.textInput.text;

			if (messageText != "")
			{
				playerAvatar.chatGroup.newBubble(messageText);
				speakUp(messageText);
			}

			starboard.gameBar.chatBox.textInput.text = "";
		}
	}

	private function speakUp(message:String):Void
	{
		if (message == "DEBUG")
		{
			FlxG.debugger.visible = true;
		}

		NetworkManager.sendRoomChat(message);
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

		playerAvatar.playerNextMovement = FlxPoint.get(0, 0);
	}

	public function receivePacket(e:ProgressEvent):Void
	{
		var byteCount:Int = Math.ceil(e.bytesLoaded);
		var serverPacket:ServerPacket = NetworkManager.handlePacket(byteCount);

		Receiver.react(serverPacket);
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
	}
}
