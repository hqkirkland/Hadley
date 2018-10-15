package communication;

import haxe.io.Bytes;
import haxe.Json;

import openfl.net.Socket;
import openfl.utils.ByteArray;

import communication.messages.Packet;
import communication.messages.OutgoingJoinPacket;
import communication.messages.OutgoingMotionPacket;

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
	}
	
	public static function sendJoinRoom(roomName:String):Void
	{
		var joinPacket:OutgoingJoinPacket = new OutgoingJoinPacket(roomName);
		
		var packetOut:ByteArrayData = makeData(joinPacket);
		networkSocket.writeBytes(packetOut);
		networkSocket.flush();
	}
	
	public static function sendMotion(north:Bool, south:Bool, east:Bool, west:Bool, run:Bool)
	{
		var motionPacket:OutgoingMotionPacket = new OutgoingMotionPacket(north, south, east, west, run);
		
		var packetOut:ByteArrayData = makeData(motionPacket);
		networkSocket.writeBytes(packetOut);
		networkSocket.flush();
	}
	
	private static function makeData(packet:Packet):ByteArray
	{
		return ByteArray.fromBytes(Bytes.ofString(Json.stringify(packet)));
	}
}