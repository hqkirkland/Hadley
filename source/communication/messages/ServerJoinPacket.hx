package communication.messages;

/**
 * ...
 * @author Hunter
 */
class ServerJoinPacket extends Packet
{
	public var fromRoom:String;
	
	public function new(packetArray:Array<String>)
	{
		super(MessageType.JoinRoom);
		fromRoom = packetArray[2];
	}
}