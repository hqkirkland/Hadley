package communication.messages;
import openfl.utils.ByteArray;

/**
 * ...
 * @author Hunter
 */
class ClientMovementPacket extends ClientPacket
{
	public function new(north:Bool, south:Bool, east:Bool, west:Bool, run:Bool)
	{
		super(MessageType.Movement);
		
		var messageData:ByteArrayData = new ByteArrayData();		
		messageData.length = 32;
		messageData.position = 6;
		
		if (north) messageData.writeByte(0x1) else messageData.writeByte(0x0);
		if (south) messageData.writeByte(0x1) else messageData.writeByte(0x0);
		if (east) messageData.writeByte(0x1) else messageData.writeByte(0x0);
		if (west) messageData.writeByte(0x1) else messageData.writeByte(0x0);
		if (run) messageData.writeByte(0x1) else messageData.writeByte(0x0);
		
		messageBytes = new ByteArrayData();
		messageBytes.length = messageData.position;
		messageBytes.writeBytes(messageData, 0, messageBytes.length);
		
		writeHeader(messageBytes.length - 6);
	}
}