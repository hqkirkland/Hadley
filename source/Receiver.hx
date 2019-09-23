package;

import flixel.FlxG;
import flixel.math.FlxPoint;

import RoomState;
import game.Avatar;
import communication.NetworkManager;
import communication.messages.MessageType;
import communication.messages.ServerPacket;
import communication.messages.ServerChangeClothesPacket;
import communication.messages.ServerJoinRoomPacket;
import communication.messages.ServerMovementPacket;
import communication.messages.ServerRoomChatPacket;
import communication.messages.ServerExitRoomPacket;
import communication.messages.ServerRoomIdentityPacket;
import communication.messages.ServerStoreOpenPacket;

/**
 * ...
 * @author Hunter
 */
class Receiver 
{
	public static function react(serverPacket:ServerPacket):Void
	{
		if (!RoomState.roomAvatars.exists(serverPacket.senderId))
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
				
				RoomState.roomAvatars.set(joinPacket.senderId, new Avatar(joinPacket.senderId));
				RoomState.roomAvatars[joinPacket.senderId].setAppearance(joinPacket.appearance);
				
				RoomState.currentRoom.addAvatar(RoomState.roomAvatars[joinPacket.senderId], joinPacket.fromRoom);				
				FlxG.state.add(RoomState.roomAvatars[joinPacket.senderId].chatGroup);
				
			case MessageType.Movement:
				var movePacket:ServerMovementPacket = cast(serverPacket, ServerMovementPacket);
				
				RoomState.roomAvatars[movePacket.senderId].keysTriggered.North = movePacket.north;
				RoomState.roomAvatars[movePacket.senderId].keysTriggered.South = movePacket.south;
				RoomState.roomAvatars[movePacket.senderId].keysTriggered.East = movePacket.east;
				RoomState.roomAvatars[movePacket.senderId].keysTriggered.West = movePacket.west;
				RoomState.roomAvatars[movePacket.senderId].keysTriggered.Run = movePacket.run;
				
				RoomState.roomAvatars[movePacket.senderId].playerNextMovement = FlxPoint.get(0, 0);
				RoomState.roomAvatars[movePacket.senderId].smoothMovement();
				
				if (RoomState.roomAvatars[movePacket.senderId].currentAction == Avatar.actionSet.Stand)
				{
					RoomState.roomAvatars[movePacket.senderId].x = movePacket.x;
					RoomState.roomAvatars[movePacket.senderId].y = movePacket.y;
				}
				
			case MessageType.RoomIdentity:
				var identityPacket:ServerRoomIdentityPacket = cast(serverPacket, ServerRoomIdentityPacket);
				RoomState.roomAvatars.set(identityPacket.senderId, new Avatar(identityPacket.senderId));
				RoomState.roomAvatars[identityPacket.senderId].setAppearance(identityPacket.appearance);
				
				RoomState.currentRoom.addAvatar(RoomState.roomAvatars[identityPacket.senderId], "");
				FlxG.state.add(RoomState.roomAvatars[identityPacket.senderId].chatGroup);
				
				if (identityPacket.x != 0 && identityPacket.y != 0)
				{
					RoomState.roomAvatars[identityPacket.senderId].x = identityPacket.x;
					RoomState.roomAvatars[identityPacket.senderId].y = identityPacket.y;
				}
				
			case MessageType.ExitRoom:
				var exitPacket:ServerExitRoomPacket = cast(serverPacket, ServerExitRoomPacket);				
				RoomState.roomAvatars[exitPacket.senderId].leaveRoom();
				FlxG.state.remove(RoomState.roomAvatars[exitPacket.senderId].chatGroup);
				RoomState.roomAvatars.remove(exitPacket.senderId);
				
			case MessageType.RoomChat:
				var roomChatPacket:ServerRoomChatPacket = cast(serverPacket, ServerRoomChatPacket);
				RoomState.roomAvatars[roomChatPacket.senderId].chatGroup.newBubble(roomChatPacket.chatMessage);
				
			case MessageType.ChangeClothes:
				var changeClothesPacket:ServerChangeClothesPacket = cast(serverPacket, ServerChangeClothesPacket);
				RoomState.roomAvatars[changeClothesPacket.senderId].setAppearance(changeClothesPacket.appearance);
				
			case MessageType.OpenStore:
				var openStorePacket:ServerStoreOpenPacket = cast(serverPacket, ServerStoreOpenPacket);
				RoomState.starboard.openStoreWindow(openStorePacket.items);
				
			default:
				return;
		}
	}
}