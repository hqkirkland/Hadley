package communication.messages;

import openfl.utils.ByteArray;
import openfl.utils.Endian;
/**
 * ...
 * @author Hunter
 */
class ClientJoinRoomPacket extends ClientPacket
{
	public function new(destRoom:String)
	{
		super(MessageType.JoinRoom);
		
		var messageData:ByteArrayData = new ByteArrayData();
		messageData.endian = Endian.BIG_ENDIAN;
		
		#if flash
		messageData.length = 32;
		#end
		
		messageData.position = 6;
		
		messageData.writeByte(destRoom.length);
		messageData.writeUTFBytes(destRoom);
		
		messageBytes = new ByteArrayData();
		
		#if flash
		messageBytes.length = messageData.position;
		#end
		
		messageBytes.writeBytes(messageData, 0, messageBytes.length);
		
		writeHeader(messageBytes.length - 6);
	}
}