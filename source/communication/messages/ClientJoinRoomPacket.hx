package communication.messages;

import openfl.utils.ByteArray;

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
		
		#if flash
		messageData.length = 32;
		#end
		
		messageData.position = 6;
		
		messageData.writeByte(destRoom.length);
		messageData.writeUTFBytes(destRoom);
		trace(messageData.position);
		
		messageBytes = new ByteArrayData();
		
		#if flash
		messageBytes.length = messageData.position;
		#end
		
		messageBytes.writeBytes(messageData, 0, messageBytes.length);
		
		writeHeader(messageBytes.length - 6);
	}
}