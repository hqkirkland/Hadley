package communication.messages;

import openfl.utils.ByteArray.ByteArrayData;
import openfl.utils.Endian;

/**
 * ...
 * @author Hunter
 */
class ClientPacket 
{
	public var messageId:Int;
	public var messageBytes:ByteArrayData;
	
	public function new(packetId:Int) 
	{
		messageId = packetId;
	}
	
	public function writeHeader(messageLength:Int):Void
	{
		messageBytes.position = 0;
		messageBytes.endian = Endian.BIG_ENDIAN;
		messageBytes.writeByte(0xa);
		messageBytes.writeShort(messageLength);
		messageBytes.writeShort(messageId);
		messageBytes.writeByte(0x1f);
	}
}