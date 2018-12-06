package communication.messages;

/**
 * ...
 * @author Hunter
 */

class MessageType
{
	public static inline var Unknown:Int = 0x00;
	public static inline var Login:Int = 0x10;
	public static inline var JoinRoom:Int = 0x11;
	public static inline var Movement:Int = 0x12;
	public static inline var Chat:Int = 0x13;
}