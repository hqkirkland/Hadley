package communication.messages;
import openfl.utils.ByteArray.ByteArrayData;

/**
 * ...
 * @author Hunter
 */
class ServerRoomIdentityPacket extends ServerPacket
{
	public var appearance:String;
	public var x:Int;
	public var y:Int;
	
	public function new(_messageBytes:ByteArrayData)
	{
		super(_messageBytes, MessageType.RoomIdentity);
		
		appearance = readString();
		x = readChar() * 24;
		y = readChar() * 24;
	}
}