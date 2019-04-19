package communication.messages;
import openfl.utils.ByteArray.ByteArrayData;

/**
 * ...
 * @author Hunter
 */
class ServerChangeClothesPacket extends ServerPacket
{
	public var appearance:String;
	
	public function new(_messageBytes:ByteArrayData)
	{
		super(_messageBytes, MessageType.ChangeClothes);
		appearance = readString();
	}
}