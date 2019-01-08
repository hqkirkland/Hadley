package;

import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.display.Shape;
import openfl.display.GradientType;
import ui.SubmitButton;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.system.scaleModes.FixedScaleMode;

import communication.api.ApiClient;
import communication.api.ApiError;
import communication.api.events.ApiEvent;
import ui.Label;
import ui.LoginInputBox;
import ui.NoticeBox;

class LoginState extends FlxState
{
	private var usernameBox:LoginInputBox;
	private var passwordBox:LoginInputBox;
	private var errorBox:Label;
	
	private static var apiClient:ApiClient;
	
	override public function create():Void
	{
		super.create();
		FlxG.autoPause = false;
		FlxG.scaleMode = new FixedScaleMode();
		apiClient = new ApiClient();
		
		var panorama:FlxSprite = new FlxSprite(0, 0, "assets/interface/login/images/panorama.png");
		add(panorama);
		
		var backgroundBox:FlxSprite = new FlxSprite(0, 0);
		backgroundBox.makeGraphic(400, 150);
		backgroundBox.x = (FlxG.width / 2) - (backgroundBox.width / 2);
		backgroundBox.y = backgroundBox.height / 2;
		//add(backgroundBox);
		
		var noticeBox:NoticeBox = new NoticeBox(400, 200, 20, "sign in");
		noticeBox.x = (FlxG.width / 2) - (noticeBox.backgroundShape.width / 2);
		noticeBox.y = noticeBox.backgroundShape.height / 2;
		add(noticeBox);
		
		usernameBox = new LoginInputBox(0xFFFFFFFF);
		usernameBox.x = noticeBox.x + (noticeBox.width / 4) + 10;
		usernameBox.y = noticeBox.y + 75;
		add(usernameBox);
		usernameBox.addElements();
		
		passwordBox = new LoginInputBox(0xFFFFFFFF, true);
		passwordBox.x = noticeBox.x + (noticeBox.width / 4) + 10;
		passwordBox.y = usernameBox.y + usernameBox.height + 3;
		add(passwordBox);
		passwordBox.addElements();
		
		var userLabel:Label = new Label();
		userLabel.x = usernameBox.x - 85;
		userLabel.y = usernameBox.y + 5;
		userLabel.addText("Username");
		
		var passwordLabel:Label = new Label();
		passwordLabel.x = passwordBox.x - 85;
		passwordLabel.y = passwordBox.y + 5;
		passwordLabel.addText("Password");
		
		add(userLabel);
		add(passwordLabel);
		
		errorBox = new Label();
		errorBox.x = usernameBox.x;
		errorBox.y = usernameBox.y - errorBox.height;
		add(errorBox);
		
		var button:SubmitButton = new SubmitButton(100, 50, "next");
		button.x = (noticeBox.x + noticeBox.width) - button.width - 15;
		button.y = (noticeBox.y + noticeBox.height) - button.height - 20;
		add(button);
		
		passwordBox.textInput.addEventListener(KeyboardEvent.KEY_DOWN, handleEnter);
	}
	
	private function handleEnter(e:KeyboardEvent):Void
	{
		if (e.keyCode == 13)
		{
			apiClient.addEventListener(ApiEvent.ERROR, handleError);
			apiClient.addEventListener(ApiEvent.LOGIN, doLogin);
			apiClient.login(usernameBox.textInput.text, passwordBox.textInput.text);
		}
	}
	
	private function handleError(e:ApiEvent)
	{
		errorBox.addText(e.error.message);
		trace(e.error.message);
	}
	
	private function doLogin(e:ApiEvent)
	{
		var successBox:NoticeBox = new NoticeBox(50, 25, 5, "Success!");
		successBox.x = 100;
		successBox.y = 100;
		add(successBox);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);		
	}
}