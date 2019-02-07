package communication.messages;
import openfl.utils.ByteArray.ByteArrayData;

/**
 * ...
 * @author Hunter
 */
class ServerRoomChatPacket extends ServerPacket
{
	public var chatMessage:String;
	
	public function new(_messageBytes:ByteArrayData)
	{
		super(_messageBytes, MessageType.RoomChat);
		chatMessage = readString();
	}
}