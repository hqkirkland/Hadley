package communication.api;

import haxe.Json;

import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.IOErrorEvent;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLRequestHeader;

import communication.api.events.ApiEvent;

/**
 * ...
 * @author Hunter
 */
class ApiClient extends EventDispatcher
{
	public var loginClient:URLLoader;
	
	public static var apiToken:Token;
	
	public function new()
	{
		super();
	}
	
	private function errorHandler(e:IOErrorEvent):Void
	{
		var urlClient:URLLoader = cast e.target;
		var statusCode:Int = Std.parseInt(e.text);
		
		if (urlClient.data != null)
		{
			var apiError:ApiError = cast Json.parse(urlClient.data);
			trace(apiError.message);
			
			if (apiError.message != null)
			{
				raiseError(apiError, statusCode);
			}
			
			else
			{
				raiseError({ message: "An unknown API error occurred. Please retry the request." }, statusCode);
			}
		}
		
		else
		{
			raiseError({ message: "An unknown API error occurred. Please retry the request." }, statusCode);
		}
	}
	
	private function raiseError(apiError:ApiError, statusCode:Int):Void
	{
		trace("Error code: " + apiError.message);
		var errorEvent:ApiEvent = new ApiEvent(ApiEvent.ERROR, statusCode);
		errorEvent.error = apiError;
		
		dispatchEvent(errorEvent);
	}
	
	private function handleStatusCode(e:IOErrorEvent)
	{
		trace(e.text);
	}
	
	private function addHandler(resource:String)
	{
		var endpoint:String = resource.substr(Endpoints.BASE_ENDPOINT.length);
		trace(endpoint);
	}
	
	public function login(username:String, password:String):Void
	{
		var loginVars:String = "{\"username\": \"" + username + "\", \"password\": \"" + password + "\"}";

		var loginRequest:URLRequest = new URLRequest(Endpoints.SIGNIN);
		loginRequest.method = "POST";
		loginRequest.data = loginVars;
		loginRequest.contentType = "application/json";
		
		loginClient = new URLLoader();
		
		loginClient.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		loginClient.addEventListener(Event.COMPLETE, loginHandler);
		
		loginClient.load(loginRequest);
	}

	private function loginHandler(e:Event):Void
	{
		var loginClient:URLLoader = cast e.target;
		
		loginClient.removeEventListener(Event.COMPLETE, loginHandler);
		loginClient.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		
		var response:Dynamic = Json.parse(loginClient.data);
		
		apiToken = cast response;
		
		var apiEvent:ApiEvent = new ApiEvent(ApiEvent.LOGIN, null, true, false);
		
		dispatchEvent(apiEvent);
	}
	
	public function fetchUserdata(userId:Int):Void
	{
		var userdataRequest:URLRequest = new URLRequest(Endpoints.USERDATA + userId);
		userdataRequest.method = "GET";
		
		var credentialsHeader:URLRequestHeader = new URLRequestHeader("Authorization", "Bearer " + apiToken.access_token);
		userdataRequest.requestHeaders.push(credentialsHeader);
		
		var userdataClient:URLLoader = new URLLoader();
		
		userdataClient.addEventListener(Event.COMPLETE, userdataHandler);
		userdataClient.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		
		userdataClient.load(userdataRequest);
	}
	
	private function userdataHandler(e:Event):Void
	{
		var userdataClient:URLLoader = cast e.target;
		
		userdataClient.removeEventListener(Event.COMPLETE, userdataHandler);
		userdataClient.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		
		var apiEvent:ApiEvent = new ApiEvent(ApiEvent.USERDATA, null, false, false);
		apiEvent.result = Json.parse(userdataClient.data);
		
		dispatchEvent(apiEvent);
	}
	
	public function fetchItemdata(?itemType:String="all"):Void
	{
		var itemdataRequest:URLRequest = new URLRequest(Endpoints.ITEMDATA + itemType);
		itemdataRequest.method = "GET";
		
		var credentialsHeader:URLRequestHeader = new URLRequestHeader("Authorization", "Bearer " + apiToken.access_token);
		itemdataRequest.requestHeaders.push(credentialsHeader);

		var itemdataClient:URLLoader = new URLLoader();
		itemdataClient.addEventListener(Event.COMPLETE, itemdataHandler);
		itemdataClient.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		itemdataClient.load(itemdataRequest);
	}
	
	private function itemdataHandler(e:Event):Void
	{
		var itemdataClient:URLLoader = cast e.target;
		
		itemdataClient.removeEventListener(Event.COMPLETE, itemdataHandler);
		itemdataClient.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		
		var apiEvent:ApiEvent = new ApiEvent(ApiEvent.ITEMDATA, null, false, false);
		apiEvent.result = itemdataClient.data;
		
		dispatchEvent(apiEvent);
	}

	public function fetchColordata():Void
	{
		var req:URLRequest = new URLRequest(Endpoints.COLORDATA);
		var colordataLoader = new URLLoader();
		colordataLoader.load(req);
		colordataLoader.addEventListener(Event.COMPLETE, colordataHandler);
	}

	private function colordataHandler(e:Event):Void
	{
		var colordataClient:URLLoader = cast e.target;

		colordataClient.removeEventListener(Event.COMPLETE, colordataHandler);
		colordataClient.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);

		var apiEvent:ApiEvent = new ApiEvent(ApiEvent.COLORDATA, null, false, false);
		apiEvent.result = colordataClient.data;

		dispatchEvent(apiEvent);
	}

	public function fetchInventory():Void
	{
		var inventoryRequest:URLRequest = new URLRequest(Endpoints.INVENTORY);
		inventoryRequest.method = "GET";
		
		var credentialsHeader:URLRequestHeader = new URLRequestHeader("Authorization", "Bearer " + apiToken.access_token);
		inventoryRequest.requestHeaders.push(credentialsHeader);

		var inventoryClient:URLLoader = new URLLoader();
		inventoryClient.addEventListener(Event.COMPLETE, inventoryHandler);
		inventoryClient.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		inventoryClient.load(inventoryRequest);
	}
	
	private function inventoryHandler(e:Event):Void
	{
		var inventoryClient:URLLoader = cast e.target;
		
		inventoryClient.removeEventListener(Event.COMPLETE, itemdataHandler);
		inventoryClient.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		
		var apiEvent:ApiEvent = new ApiEvent(ApiEvent.INVENTORY, null, false, false);
		apiEvent.result = inventoryClient.data;
		
		dispatchEvent(apiEvent);
	}
}