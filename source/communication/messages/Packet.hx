package communication.messages;
import haxe.io.Bytes;
import openfl.utils.ByteArray;

/**
 * ...
 * @author Hunter
 */

class Packet
{
	public var messageBytes:ByteArray;
	public var messageId:MessageType;
	
	public function new(type:MessageType)
	{
		messageBytes = new ByteArray(1024);
		messageId = type;
		
		messageBytes.writeByte(0x33);
		messageBytes.writeByte(0x01);
		endSegment();
		
		switch (type)
		{
			case MessageType.JoinRoom:
				pushByte(0x10);
			case MessageType.Motion:
				pushByte(0x11);
			default:
		}
	}
	
	public function pushByte(value:Int):Void
	{
		messageBytes.writeByte(value);
		endSegment();
	}
	
	public function pushString(value:String):Void
	{
		messageBytes.writeBytes(ByteArray.fromBytes(Bytes.ofString(value)));
		endSegment();
	}
	
	public function writeString(value:String):Void
	{
		messageBytes.writeBytes(ByteArray.fromBytes(Bytes.ofString(value)));
	}
	
	public function pushArray(value:Array<String>):Void
	{
		var count:Int = 0;
		
		for (item in value)
		{
			count++;
			writeString(item);
			
			if (count != value.length)
			{
				messageBytes.writeByte("^".code);
			}
			
			else
			{
				endSegment();
			}
		}
	}
	
	public function endSegment():Void
	{
		messageBytes.writeByte("|".code);
	}
	
	public static function parseArray(value:String):Array<String>
	{
		return value.split("^");
	}
}