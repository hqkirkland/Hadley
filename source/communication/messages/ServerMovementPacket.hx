package communication.messages;
import openfl.utils.ByteArray.ByteArrayData;

/**
 * ...
 * @author Hunter
 */
class ServerMovementPacket extends ServerPacket
{
	public var roomName:String;
	
	public function new(_messageBytes:ByteArrayData)
	{
		super(_messageBytes, MessageType.Movement);
		roomName = readString();
	}
}