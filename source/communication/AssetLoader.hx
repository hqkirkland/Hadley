package communication;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.events.Event;
import openfl.events.IOErrorEvent;

/**
 * ...
 * @author ...
 */
class AssetLoader 
{
	var contentLoader:URLLoader;
	/*
	public function new(AssetName:String, BaseLocation:String) 
	{
		var contentRequest = new URLRequest("/assets/images/" + AssetName + ".png");
		contentLoader = new URLLoader(contentRequest);
		contentLoader.addEventListener(Event.COMPLETE, requestComplete);
		contentLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, requestComplete);
		contentLoader.addEventListener(IOErrorEvent.IO_ERROR, requestError);
	}
	
	public function requestComplete(completeEvent:Event)
	{
		completeEvent.
	}
	
	public function requestError(errorEvent:IOErrorEvent)
	{
		
	}
	*/
}