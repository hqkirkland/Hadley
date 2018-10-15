package communication.messages;
/**
 * @author Hunter
 */

class OutgoingJoinPacket implements Packet
{
	public var id:Int = 10;
	public var body:Dynamic;
	
	public function new(toRoom:String)
	{
		body.toRoom = toRoom;
	}
}