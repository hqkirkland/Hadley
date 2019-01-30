package communication.api.events;
import communication.api.ApiError;
import openfl.events.Event;

/**
 * ...
 * @author Hunter
 */
class ApiEvent extends Event
{
	public var result:Dynamic;
	public var statusCode:Int = 0;
	public var error:ApiError;
	
	public static inline var LOGIN:String = "Login";
	public static inline var REFRESH:String = "RefreshToken";
	public static inline var USERDATA:String = "FetchUserData";
	public static inline var ERROR:String = "ApiError";
	
	public function new(type:String, ?status:Int=200, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);
		statusCode = status;
	}
}