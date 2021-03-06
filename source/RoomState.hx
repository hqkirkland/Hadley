package;

import communication.NetworkManager;
import communication.messages.ServerPacket;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.plugin.FlxMouseControl;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.util.FlxColor;
import game.ClientData;
import game.Portal;
import game.Room;
import game.avatar.Avatar;
import openfl.Assets;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.ProgressEvent;
import openfl.utils.AssetLibrary;
import sound.SoundManager;
import ui.StarboardInterface;

class RoomState extends FlxState
{

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
	private static var username:String;
	private static var loginAppearance:String;

	override public function new(_gameTicket:String, _username:String, _loginAppearance:String)
	{
		super();
		gameTicket = _gameTicket;
		username = _username;
		loginAppearance = _loginAppearance;
	}

	override public function create():Void
	{
		super.create();

		FlxG.scaleMode = new FixedScaleMode();

		FlxG.autoPause = false;
		FlxG.sound.muteKeys = null;
		FlxG.sound.volumeDownKeys = null;
		FlxG.sound.volumeUpKeys = null;

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

		RoomState.playerAvatar.setAppearance(loginAppearance);
		RoomState.starboard.changeAppearance(loginAppearance);

		NetworkManager.connect("whirlpool.nodebay.com", 8443, playerAvatar.username);
		NetworkManager.networkSocket.addEventListener(Event.CONNECT, doLogin);
		NetworkManager.networkSocket.addEventListener(ProgressEvent.SOCKET_DATA, receivePacket);
	}

	private function doLogin(e:Event):Void
	{
		NetworkManager.sendAuthenticate(gameTicket);
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
		FlxG.cameras.reset();

		Assets.registerLibrary(currentRoom.roomName, completeLib);

		var roomStructure:String = Assets.getText(currentRoom.roomName + ":assets/" + currentRoom.roomName + "/" + currentRoom.roomName + "_Objects.json");
		currentRoom.generateRoom(roomStructure);
		currentRoom.addAvatar(playerAvatar, exitRoom);
		exitRoom = "";

		starboardCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
		starboardCamera.bgColor = FlxColor.TRANSPARENT;

		this.bgColor = currentRoom.backgroundColor;

		setupGameCamera();

		FlxG.cameras.add(gameCamera);
		FlxG.cameras.add(starboardCamera);

		starboard.scrollFactor.set(0, 0);

		currentRoom.cameras = [gameCamera];
		currentRoom.vehicleEntities.cameras = [gameCamera];
		currentRoom.roomEntities.cameras = [gameCamera];
		currentRoom.portalEntities.cameras = [gameCamera];
		playerAvatar.chatGroup.cameras = [gameCamera];

		add(currentRoom);
		add(currentRoom.vehicleEntities);
		add(currentRoom.roomEntities);
		add(currentRoom.portalEntities);
		// add(currentRoom.walkMap);
		add(playerAvatar.chatGroup);
		trace("currentRoom: " + currentRoom.x + ", " + currentRoom.y);

		starboard.cameras = [starboardCamera];
		add(starboard);

		starboard.gameBar.chatBox.textInput.addEventListener(KeyboardEvent.KEY_DOWN, chatBarEnter);

		FlxG.watch.addMouse();

		currentRoom.portalEntities.visible = false;
		NetworkManager.sendJoinRoom(currentRoom.roomName);
	}

	private function setupGameCamera():Void
	{
		var CAMERA_X:Float;
		var CAMERA_WIDTH:Float;
		var CAMERA_Y:Float;
		var CAMERA_HEIGHT:Float;
		var MIRROR_OVERHANG:Int = 40;

		if (currentRoom.width < FlxG.width)
		{
			CAMERA_X = (FlxG.width / 2) - (currentRoom.width / 2);
			CAMERA_WIDTH = currentRoom.width;
		}
		else
		{
			CAMERA_X = 0;
			CAMERA_WIDTH = FlxG.width;
		}

		if (currentRoom.height < FlxG.height)
		{
			CAMERA_Y = (FlxG.height / 2) - (currentRoom.height / 2);
			CAMERA_HEIGHT = currentRoom.height;
		}
		else
		{
			CAMERA_Y = 0;
			CAMERA_HEIGHT = FlxG.height - (starboard.gameBar.height - MIRROR_OVERHANG);
		}

		gameCamera = new FlxCamera(Std.int(CAMERA_X), Std.int(CAMERA_Y), Std.int(CAMERA_WIDTH), Std.int(CAMERA_HEIGHT));
		gameCamera.bgColor = this.bgColor;

		gameCamera.follow(playerAvatar, FlxCameraFollowStyle.LOCKON, 1.0);
		gameCamera.setScrollBoundsRect(currentRoom.x, currentRoom.y, currentRoom.width, currentRoom.height, true);
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
		if (message == "DEBUG_BOXES")
		{
			FlxG.debugger.drawDebug = true;
		}

		else
		{
			NetworkManager.sendRoomChat(message);
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
