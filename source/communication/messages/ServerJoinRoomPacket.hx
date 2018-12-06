package communication.messages;
import openfl.utils.ByteArray.ByteArrayData;

/**
 * ...
 * @author Hunter
 */
class ServerJoinRoomPacket extends ServerPacket
{
	public var fromRoom:String;
	
	public function new(_messageBytes:ByteArrayData)
	{
		super(_messageBytes, MessageType.JoinRoom);
		fromRoom = readString();
	}
}