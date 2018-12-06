package communication.messages;

import communication.messages.MessageType;
import openfl.utils.ByteArray.ByteArrayData;
/**
 * ...
 * @author Hunter
 */
class ServerPacket 
{
	public var messageId:Int;
	public var messageBytes:ByteArrayData;	
	public var senderId:String;
	
	public function new(_messageBytes:ByteArrayData, ?_messageId:Int=0)
	{
		messageBytes = _messageBytes;
		messageId = _messageId;
		
		messageBytes.position = 6;
		senderId = readString();
	}
	
	public function readString():String
	{
		var stringLength:Int = readChar();
		return messageBytes.readUTFBytes(stringLength);
	}
	
	public function readChar():Int
	{
		// Unsigned 1-byte integer.
		return messageBytes.readUnsignedByte();
	}
	
	public function readInt16():Int
	{
		// Signed 2-byte integer.
		return messageBytes.readShort();
	}
	
	public function readUInt16():Int
	{
		// Unsigned 2-byte integer.
		return messageBytes.readUnsignedShort();
	}
	
	public function readInt32():Int
	{
		// Signed 4-byte integer.
		return messageBytes.readInt();
	}

}