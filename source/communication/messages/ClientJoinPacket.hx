package communication.messages;
/**
 * @author Hunter
 */

class ClientJoinPacket extends Packet
{
	public function new(toRoom:String)
	{
		super(MessageType.JoinRoom);
		this.pushString(toRoom);
	}
}