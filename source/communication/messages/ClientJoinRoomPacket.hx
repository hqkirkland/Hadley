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
		
		messageData.length = 32;
		
		messageData.position = 6;
		
		messageData.writeByte(destRoom.length);
		messageData.writeUTFBytes(destRoom);
		trace(messageData.position);
		
		messageBytes = new ByteArrayData();
		messageBytes.length = messageData.position;
		messageBytes.writeBytes(messageData, 0, messageBytes.length);
		
		writeHeader(messageBytes.length - 6);
	}
}