package communication.messages;

import openfl.utils.ByteArray;
import openfl.utils.Endian;
/**
 * ...
 * @author Hunter
 */
class ClientRoomChatPacket extends ClientPacket
{
	public function new(chatMessage:String)
	{
		super(MessageType.RoomChat);
		
		var messageData:ByteArrayData = new ByteArrayData();
		messageData.endian = Endian.BIG_ENDIAN;
		
		#if flash
		messageData.length = 255;
		#end
		
		messageData.position = 6;
		
		messageData.writeByte(chatMessage.length);
		messageData.writeUTFBytes(chatMessage);
		
		messageBytes = new ByteArrayData();
		
		#if flash
		messageBytes.length = messageData.position;
		#end
		
		messageBytes.writeBytes(messageData, 0, messageBytes.length);
		
		writeHeader(messageBytes.length - 6);
	}
}