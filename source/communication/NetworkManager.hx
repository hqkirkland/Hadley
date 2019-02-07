package communication;

import communication.messages.ClientRoomChatPacket;
import communication.messages.ServerExitRoomPacket;
import openfl.net.Socket;
import openfl.events.Event;
import openfl.utils.ByteArray;
import openfl.utils.Endian;

import communication.messages.MessageType;
import communication.messages.ClientAuthenticatePacket;
import communication.messages.ClientJoinRoomPacket;
import communication.messages.ClientMovementPacket;
import communication.messages.ServerPacket;
import communication.messages.ServerJoinRoomPacket;
import communication.messages.ServerMovementPacket;
import communication.messages.ServerRoomIdentityPacket;
import communication.messages.ServerRoomChatPacket;
/**
 * ...
 * @author Hunter
 */
class NetworkManager
{
	public static var isConnected:Bool;
	public static var networkSocket:Socket;
	
	private static var username;
	private static var ticket;
	
	public static function connect(ipAddress:String, port:Int, _username:String, _ticket:String)
	{
		username = _username;
		ticket = _ticket;
		
		networkSocket = new Socket();
		networkSocket.connect(ipAddress, port);
		networkSocket.timeout = 1800;
	}
	
	public static function handlePacket(packetLength:Int):ServerPacket
	{
		var netBytes:ByteArrayData = new ByteArrayData();
		netBytes.endian = Endian.BIG_ENDIAN;
		
		#if flash
		netBytes.length = packetLength;
		#end
		
		networkSocket.readBytes(netBytes);
		netBytes.position = 3;
		
		var packetId:Int = netBytes.readShort();
		
		switch (packetId)
		{
			case MessageType.JoinRoom:
				return new ServerJoinRoomPacket(netBytes);
			case MessageType.Movement:
				return new ServerMovementPacket(netBytes);
			case MessageType.RoomIdentity:
				return new ServerRoomIdentityPacket(netBytes);
			case MessageType.ExitRoom:
				return new ServerExitRoomPacket(netBytes);
			case MessageType.RoomChat:
				return new ServerRoomChatPacket(netBytes);
			default:
				return new ServerPacket(new ByteArrayData());
		}
		
		return new ServerPacket(new ByteArrayData());
	}
	
	public static function sendAuthenticate():Void
	{
		isConnected = true;
		networkSocket.flush();
		networkSocket.writeBytes(new ClientAuthenticatePacket(username, ticket).messageBytes);
		networkSocket.flush();
	}
	
	public static function sendJoinRoom(roomName:String):Void
	{
		networkSocket.flush();
		networkSocket.writeBytes(new ClientJoinRoomPacket(roomName).messageBytes);
		networkSocket.flush();
	}
	
	public static function sendMotion(north:Bool, south:Bool, east:Bool, west:Bool, run:Bool, x:Float=0, y:Float=0)
	{
		networkSocket.flush();
		networkSocket.writeBytes(new ClientMovementPacket(north, south, east, west, run, x, y).messageBytes);
		networkSocket.flush();
	}
	
	public static function sendRoomChat(chatMessage:String):Void
	{
		networkSocket.flush();
		networkSocket.writeBytes(new ClientRoomChatPacket(chatMessage).messageBytes);
		networkSocket.flush();
	}
}