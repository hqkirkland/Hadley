package;

import openfl.Assets;
import openfl.utils.AssetLibrary;
import openfl.events.KeyboardEvent;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.plugin.FlxMouseControl;
import flixel.addons.ui.FlxUIInputText;
import flixel.system.scaleModes.FixedScaleMode;

import communication.api.ApiClient;
import communication.api.events.ApiEvent;
import ui.login.Label;
import ui.login.LoginInputBox;
import ui.login.NoticeBox;
import ui.login.SubmitButton;

class LoginState extends FlxState
{
	private var backgroundBox:NoticeBox;
	private var usernameBox:LoginInputBox;
	private var passwordBox:LoginInputBox;
	private var noticeLabel:Label;
	private var newUsernameBox:FlxUIInputText;
	
	private static var apiClient:ApiClient;
	
	override public function create():Void
	{
		super.create();
		
		Assets.loadLibrary("starboard").onComplete(libraryLoaded);
		Assets.cache.enabled = false;
		
		FlxG.autoPause = false;
		FlxG.scaleMode = new FixedScaleMode();
		FlxG.keys.preventDefaultKeys = [];
		FlxG.mouse.useSystemCursor = true;
		FlxG.plugins.add(new FlxMouseControl());

		apiClient = new ApiClient();
		
		var panorama:FlxSprite = new FlxSprite(0, 0, "assets/interface/login/images/panorama.png");
		add(panorama);
		
		backgroundBox = new NoticeBox(400, 200, "sign in");
		backgroundBox.x = (FlxG.width / 2) - (backgroundBox.backgroundShape.width / 2);
		backgroundBox.y = backgroundBox.backgroundShape.height / 2;
		add(backgroundBox);
				
		usernameBox = new LoginInputBox(0xFFFFFFFF);
		usernameBox.x = backgroundBox.x + (backgroundBox.width / 4) + 10;
		usernameBox.y = backgroundBox.y + 75;
		add(usernameBox);
		usernameBox.addElements();
		
		passwordBox = new LoginInputBox(0xFFFFFFFF, true);
		passwordBox.x = backgroundBox.x + (backgroundBox.width / 4) + 10;
		passwordBox.y = usernameBox.y + usernameBox.height + 3;
		add(passwordBox);
		passwordBox.addElements();
		
		var userLabel:Label = new Label("Username");
		userLabel.x = usernameBox.x - 85;
		userLabel.y = usernameBox.y + 5;
		
		var passwordLabel:Label = new Label("Password");
		passwordLabel.x = passwordBox.x - 85;
		passwordLabel.y = passwordBox.y + 5;
		
		add(userLabel);
		add(passwordLabel);
		
		noticeLabel = new Label("");
		noticeLabel.x = backgroundBox.x + 20;
		noticeLabel.y = backgroundBox.y + 50;
		add(noticeLabel);
		
		var loginButton:SubmitButton = new SubmitButton(100, 50, "login", onClick);
		loginButton.x = (backgroundBox.x + backgroundBox.width) - loginButton.width - 15;
		loginButton.y = (backgroundBox.y + backgroundBox.height) - loginButton.height - 20;
		add(loginButton);
		
		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleSpecialKey);
	}
	
	private function libraryLoaded(completeLib:AssetLibrary):Void
	{
		Assets.registerLibrary("starboard", completeLib);
	}
	
	private function onClick():Void
	{
		apiClient.addEventListener(ApiEvent.ERROR, handleError);
		apiClient.addEventListener(ApiEvent.LOGIN, doLogin);
		apiClient.login(usernameBox.textInput.text, passwordBox.textInput.text);
	}
	
	private function handleSpecialKey(e:KeyboardEvent):Void
	{
		if (e.keyCode == 13)
		{
			onClick();
		}
	}
	
	private function handleError(e:ApiEvent):Void
	{
		if (e.statusCode == 401)
		{
			e.error.message = "The username or password was incorrect.";
		}
		
		trace(e.statusCode);
		
		notifyError(e.error.message);		
		trace(e.error.message);
	}
	
	private function notifyError(text:String)
	{
		remove(noticeLabel);
		
		noticeLabel = new Label(text, 14, 0xFF800000);
		noticeLabel.x = backgroundBox.x + 20;
		noticeLabel.y = backgroundBox.y + 50;
		add(noticeLabel);
	}
	
	private function notifySuccess(text:String)
	{
		remove(noticeLabel);
		
		noticeLabel = new Label(text, 14, 0xFF008800);
		noticeLabel.x = backgroundBox.x + 20;
		noticeLabel.y = backgroundBox.y + 50;
		add(noticeLabel);
	}
	
	private function notifyNotice(text:String)
	{
		remove(noticeLabel);
		
		noticeLabel = new Label(text);
		noticeLabel.x = backgroundBox.x + 20;
		noticeLabel.y = backgroundBox.y + 50;
		add(noticeLabel);
	}
	
	private function doLogin(e:ApiEvent):Void
	{
		apiClient.removeEventListener(ApiEvent.LOGIN, doLogin);
		apiClient.addEventListener(ApiEvent.USERDATA, fetchComplete);
		
		// Must use static instance of apiToken.
		apiClient.fetchUserdata(ApiClient.apiToken.userId);
	}
	
	private function fetchComplete(e:ApiEvent):Void
	{
		apiClient.removeEventListener(ApiEvent.USERDATA, fetchComplete);
		FlxG.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleSpecialKey);
		
		trace("Welcome, " + e.result.username);
		
		var _roomState:RoomState = new RoomState(ApiClient.apiToken.gameTicket);
		_roomState.username = e.result.username;
		
		usernameBox.removeElements();
		passwordBox.removeElements();
		
		FlxG.switchState(_roomState);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}