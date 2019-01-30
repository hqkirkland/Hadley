package communication.messages;

/**
 * ...
 * @author Hunter
 */

class MessageType
{
	public static inline var Unknown:Int = 0x0;
	public static inline var Authenticate:Int = 0x3;
	public static inline var JoinRoom:Int = 0x11;
	public static inline var Movement:Int = 0x12;
	public static inline var Chat:Int = 0x13;
	public static inline var RoomIdentity:Int = 0x15;
}