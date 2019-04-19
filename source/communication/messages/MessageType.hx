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
	public static inline var ExitRoom:Int = 0x14;
	public static inline var RoomIdentity:Int = 0x15;
	public static inline var RoomChat:Int = 0x16;
	public static inline var ChangeClothes:Int = 0x17;

}