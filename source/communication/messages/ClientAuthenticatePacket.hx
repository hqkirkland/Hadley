package communication.messages;

import openfl.utils.ByteArray.ByteArrayData;

/**
 * ...
 * @author Hunter
 */
class ClientAuthenticatePacket extends ClientPacket
{
	public function new(senderId:String, ticket:String)
	{
		super(MessageType.Authenticate);
		
		var messageData:ByteArrayData = new ByteArrayData();
		
		#if flash
		messageData.length = 32;
		#end
		
		messageData.position = 6;
		
		messageData.writeByte(senderId.length);
		messageData.writeUTFBytes(senderId);
		
		messageData.writeByte(ticket.length);
		messageData.writeUTFBytes(ticket);
		
		messageBytes = new ByteArrayData();
		
		#if flash
		messageBytes.length = messageData.position;
		#end
		
		messageBytes.writeBytes(messageData, 0, messageBytes.length);
		
		writeHeader(messageBytes.length - 6);
	}
}