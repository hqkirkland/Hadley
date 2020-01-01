package communication.api;

/**
 * ...
 * @author Hunter
 */
class Endpoints 
{
	public static inline var BASE_ENDPOINT = "https://dreamland.nodebay.com";
	// public static inline var BASE_ENDPOINT = "http://72.182.108.158:5000";
	public static inline var SIGNIN = BASE_ENDPOINT + "/auth/signin";
	public static inline var USERDATA = BASE_ENDPOINT + "/userdata/";
	public static inline var ITEMDATA = BASE_ENDPOINT + "/gamedata/itemdata/";
	public static inline var COLORDATA = BASE_ENDPOINT + "/gamedata/colors";
}