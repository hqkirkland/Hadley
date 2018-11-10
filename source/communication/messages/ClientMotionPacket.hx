package communication.messages;
/**
 * @author Hunter
 */

class ClientMotionPacket extends Packet
{
	public function new(north:Bool, south:Bool, east:Bool, west:Bool, run:Bool)
	{
		super(MessageType.Motion);
		
		var motionArray:Array<String> = new Array<String>();
		
		if (north) motionArray.push("+") else motionArray.push("-");
		if (south) motionArray.push("+") else motionArray.push("-");
		if (east)  motionArray.push("+") else motionArray.push("-");
		if (west)  motionArray.push("+") else motionArray.push("-");
		if (run)   motionArray.push("+") else motionArray.push("-");
		
		this.pushArray(motionArray);
	}
}