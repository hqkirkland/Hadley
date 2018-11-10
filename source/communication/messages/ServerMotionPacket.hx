package communication.messages;

/**
 * ...
 * @author Hunter
 */
class ServerMotionPacket extends Packet
{
	public var north:Bool;
	public var south:Bool;
	public var east:Bool;
	public var west:Bool;
	public var run:Bool;
	
	public function new(packetArray:Array<String>)
	{
		super(MessageType.Motion);
		
		var motionStrArray:Array<String> = Packet.parseArray(packetArray[2]);
		
		north = motionStrArray[0].charCodeAt(0) == "+".code;
		south = motionStrArray[1].charCodeAt(0) == "+".code;
		east  = motionStrArray[2].charCodeAt(0) == "+".code;
		west  = motionStrArray[3].charCodeAt(0) == "+".code;
		run   = motionStrArray[4].charCodeAt(0) == "+".code;
	}
}