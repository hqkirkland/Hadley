package communication;

import openfl.net.Socket;
import openfl.utils.ByteArray;

import communication.messages.MessageType;
import communication.messages.ClientPacket;
import communication.messages.ClientJoinRoomPacket;
import communication.messages.ClientMovementPacket;
import communication.messages.ServerPacket;
import communication.messages.ServerJoinRoomPacket;
import communication.messages.ServerMovementPacket;
/**
 * ...
 * @author Hunter
 */
class NetworkManager
{
	public static var isConnected:Bool;
	public static var networkSocket:Socket;
	
	public static function connect(ipAddress:String, port:Int)
	{
		networkSocket = new Socket(ipAddress, port);
		networkSocket.timeout = 1800;
	}
	
	public static function handlePacket(packetLength:Int):ServerPacket
	{
		var netBytes:ByteArrayData = new ByteArrayData();
		netBytes.length = packetLength;
		networkSocket.readBytes(netBytes);
		netBytes.position = 3;
		
		var packetId:Int = netBytes.readShort();
		trace(packetId);
		
		switch (packetId)
		{
			case MessageType.JoinRoom:
				return new ServerJoinRoomPacket(netBytes);
			case MessageType.Movement:
				return new ServerMovementPacket(netBytes);
		}
		
		return new ServerPacket(new ByteArrayData());
	}
	
	public static function sendJoinRoom(roomName:String):Void
	{
		networkSocket.writeBytes(new ClientJoinRoomPacket(roomName).messageBytes);
		networkSocket.flush();
	}
	
	public static function sendMotion(north:Bool, south:Bool, east:Bool, west:Bool, run:Bool)
	{
		networkSocket.writeBytes(new ClientMovementPacket(north, south, east, west, run).messageBytes);
		networkSocket.flush();
	}
}