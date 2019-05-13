package game;

/**
 * @author Hunter
 */
class ClothingType
{
	public static inline var BODY:String = "Body";
	public static inline var SHOES:String = "Shoes";
	public static inline var PANTS:String = "Pants";
	public static inline var SHIRT:String = "Shirt";
	public static inline var FACE:String = "Face";
	public static inline var GLASSES:String = "Glasses";
	public static inline var HAIR:String = "Hair";
	public static inline var HAT:String = "Hat";
	public static inline var DEFAULT_CLOTHING = "Clothing";
	
	public static inline function typeToNum(typeString:String):Int
	{
		switch (typeString)
		{
			case BODY:
				return 0;
			case SHOES:
				return 1;
			case PANTS:
				return 2;
			case SHIRT:
				return 3;
			case FACE:
				return 5;
			case HAIR:
				return 6;
			case GLASSES:
				return 7;
			case HAT:
				return 8;
			default:
				return -1;
		}
	}
}