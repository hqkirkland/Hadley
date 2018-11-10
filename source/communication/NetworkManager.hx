package communication;

import haxe.Utf8;

import openfl.net.Socket;
import openfl.utils.ByteArray;

import communication.messages.ClientMotionPacket;
import communication.messages.MessageType;
import communication.messages.Packet;
import communication.messages.ServerJoinPacket;
import communication.messages.ServerMotionPacket;
import communication.messages.ClientJoinPacket;

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
	
	public static function handlePacket(packetLength:Int):Packet
	{
		var netBytes:ByteArrayData = new ByteArrayData();
		netBytes.length = packetLength;
		networkSocket.readBytes(netBytes);
		netBytes.position = 3;
		trace(netBytes.toString());
		
		var packetId:Int = netBytes.readByte();
		netBytes.position = 0;
		
		var messageString:String = netBytes.toString();
		var packetBody:Array<String> = messageString.split("|");
		
		switch (packetId)
		{
			case 0x10:
				return new ServerJoinPacket(packetBody);
			case 0x11:
				return new ServerMotionPacket(packetBody);
		}
		
		return new Packet(MessageType.Unknown);
	}

	public static function sendJoinRoom(roomName:String):Void
	{
		var joinPacket:ClientJoinPacket = new ClientJoinPacket(roomName);
		networkSocket.writeBytes(joinPacket.messageBytes);
		networkSocket.flush();
	}
	
	public static function sendMotion(north:Bool, south:Bool, east:Bool, west:Bool, run:Bool)
	{		
		var motionPacket:ClientMotionPacket = new ClientMotionPacket(north, south, east, west, run);
		networkSocket.writeBytes(motionPacket.messageBytes);
		networkSocket.flush();
	}
}