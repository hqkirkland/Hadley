package communication.messages;
import openfl.utils.ByteArray.ByteArrayData;

/**
 * ...
 * @author Hunter
 */
class ServerExitRoomPacket extends ServerPacket
{
	public function new(_messageBytes:ByteArrayData)
	{
		super(_messageBytes, MessageType.ExitRoom);
	}
}