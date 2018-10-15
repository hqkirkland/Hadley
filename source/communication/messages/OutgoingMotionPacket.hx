package communication.messages;
import openfl.utils.Object;
/**
 * @author Hunter
 */

class OutgoingMotionPacket implements Packet
{
	public var id:Int = 11;
	public var body:Dynamic;
	
	public function new(north:Bool, south:Bool, east:Bool, west:Bool, run:Bool)
	{		
		body.north = north;
		body.south = south;
		body.east = east;
		body.west = west;
		body.run = run;
	}
}