package communication.api;
import haxe.Json;
import openfl.net.URLLoader;
import openfl.utils.Object;

/**
 * ...
 * @author Hunter
 */
class ApiClient 
{
	private var apiLoader:URLLoader;
	
	public function new() 
	{
		apiLoader = new URLLoader("http://localhost:5000/gamedata/colors");
	}
	
	public function getUserdata(id:Int):Dynamic
	{
		var response:String = new URLLoader(
		Json.parse(response);
	}
}