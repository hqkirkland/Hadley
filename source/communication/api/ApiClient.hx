package communication.api;

import haxe.Json;

import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.ProgressEvent;
import openfl.events.IOErrorEvent;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLVariables;

import communication.api.events.ApiEvent;

/**
 * ...
 * @author Hunter
 */
class ApiClient extends EventDispatcher
{
	public var apiToken:Token;
	public var loginClient:URLLoader;
	
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

	private function progressHandler(e:ProgressEvent):Void
	{
		trace("Progress made.");
	}
	
	/*
	public function login(username:String, password:String):Void
	{
		var httpReq:HTTPRequest = new HTTPRequest();
		httpReq
	}*/
	
	public function login(username:String, password:String):Void
	{		
		var loginVars:URLVariables = new URLVariables();
		loginVars.username = username;
		loginVars.password = password;
		
		var loginRequest:URLRequest = new URLRequest(Endpoints.SIGNIN);
		loginRequest.method = "POST";
		loginRequest.data = loginVars;
		
		loginClient = new URLLoader();
		
		loginClient.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		loginClient.addEventListener(Event.COMPLETE, loginHandler);
		loginClient.load(loginRequest);
	}

	private function loginHandler(e:Event):Void
	{
		var loginClient:URLLoader = cast e.target;
		var response:Dynamic = Json.parse(loginClient.data);
		
		apiToken = cast response;
		
		var apiEvent:ApiEvent = new ApiEvent(ApiEvent.LOGIN, null, true, false);
		dispatchEvent(apiEvent);
	}
	
	public function fetchUserdata(userId:Int):Void
	{
		var userdataRequest:URLRequest = new URLRequest(Endpoints.USERDATA + userId);
		userdataRequest.method = "GET";
		
		var userdataClient:URLLoader = new URLLoader();
		userdataClient.addEventListener(Event.COMPLETE, userdataHandler);
		userdataClient.load(userdataRequest);
	}
	
	private function userdataHandler(e:Event):Void
	{
		var userdataClient:URLLoader = cast e.target;
		trace(userdataClient.data);
		
		var apiEvent:ApiEvent = new ApiEvent(ApiEvent.USERDATA, false, false);
		apiEvent.result = userdataClient.data;
		dispatchEvent(apiEvent);
	}
}