package communication.messages;
import openfl.utils.ByteArray.ByteArrayData;

/**
 * ...
 * @author Hunter
 */
class ServerMovementPacket extends ServerPacket
{
	public var north:Bool;
	public var south:Bool;
	public var east:Bool;
	public var west:Bool;
	public var run:Bool;
	public var x:Int;
	public var y:Int;
	
	public function new(_messageBytes:ByteArrayData)
	{
		super(_messageBytes, MessageType.Movement);
		
		north = readChar() == 0x1;
		south = readChar() == 0x1;
		east = readChar() == 0x1;
		west = readChar() == 0x1;
		run = readChar() == 0x1;
		
		x = readUInt16();
		y = readUInt16();
	}
}