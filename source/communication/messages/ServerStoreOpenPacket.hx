package communication.messages;

import openfl.utils.ByteArray.ByteArrayData;

/**
 * ...
 * @author Hunter
 */
class ServerStoreOpenPacket extends ServerPacket
{
	public var items:Array<Int>;
	
	public function new(_messageBytes:ByteArrayData)
	{
		super(_messageBytes, MessageType.OpenStore);
		
		items = new Array<Int>();
		
		var itemList:String = readString();
		var itemSet:Array<String> = itemList.split(",");
		
		for (item in itemSet)
		{
			items.push(Std.parseInt(item));
		}
	}
}