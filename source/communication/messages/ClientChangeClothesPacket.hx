package communication.messages;

import openfl.utils.ByteArray;
import openfl.utils.Endian;
/**
 * ...
 * @author Hunter
 */
class ClientChangeClothesPacket extends ClientPacket
{
	public function new(appearanceString:String)
	{
		super(MessageType.ChangeClothes);
		
		var messageData:ByteArrayData = new ByteArrayData();
		messageData.endian = Endian.BIG_ENDIAN;
		
		#if flash
		messageData.length = 64;
		#end
		
		messageData.position = 6;
		
		messageData.writeByte(appearanceString.length);
		messageData.writeUTFBytes(appearanceString);
		
		messageBytes = new ByteArrayData();
		
		#if flash
		messageBytes.length = messageData.position;
		#end
		
		messageBytes.writeBytes(messageData, 0, messageBytes.length);
		
		writeHeader(messageBytes.length - 6);
	}
}