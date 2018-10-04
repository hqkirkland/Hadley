package communication;

import openfl.net.Socket;

/**
 * ...
 * @author Hunter
 */
class GameConnection 
{	
	public var senderId:String;
	public var channelId:String;
	
	private var netsock:Socket;
	
	public function new() 
	{
		netsock = new Socket("71.78.101.154", 1626);
	}
}