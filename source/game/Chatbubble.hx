package game;

import openfl.Assets;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxText;

import util.FlxBitmapTextBlittable;

/**
 * ...
 * @author Hunter
 */
class ChatBubble extends FlxSprite
{
	public var bubbleWidth:Int = 0;
	public var bubbleHeight:Int = 0;
	
	private var fontData:String;
	private var chatFont:FlxBitmapFont;
	private var textFormat:FlxTextFormat;
	private	var lines:Array<String> = new Array<String>();
	private var bubbleCorner:FlxSprite;
	private var bubbleOutline:FlxSprite;
	private var bubblePointer:FlxSprite;
	
	public static var MAX_LINE:Int = 115;
	
	private static var LINE_MARGIN:Int = 15;
	private static var useDefaultRenderMethod:Bool;
	
	// TODO: This class can be made way more efficient, a la re-used bubble corners
	// and Bitmap usage instead of FlxSprite.
	// Could possibly be performance=enhanced by 9=slicing? Probably.
	public function new(speaker:String, messageContent:String, gender:Int)
	{
		super();
		this.alpha = 0;
		
		var message:String = speaker + ": " + messageContent;
		
		fontData = Assets.getText(AssetPaths.arialBitmap_Size14px__fnt);
		chatFont = FlxBitmapFont.fromAngelCode(AssetPaths.arialBitmap_Size14px_0__png, Xml.parse(fontData));
		textFormat = new FlxTextFormat(0x0);
		
		bubbleCorner = new FlxSprite(0, 0, Assets.getBitmapData("assets/images/interface/bubble_1_1_0.png"));
		bubblePointer = new FlxSprite(0, 0, Assets.getBitmapData("assets/images/interface/bubble_1_5_0.png"));
		bubbleOutline = new FlxSprite(0, 0, Assets.getBitmapData("assets/images/interface/bubble_1_6_0.png"));
		
		makeLinesOptimized(message);
		generateBubble(speaker, gender);
	}
	
	private function makeLinesOptimized(message:String)
	{
		var currentLine:String = "";
		var currentLineWidth:Int = 0;
		
		var currentWord:String = "";
		var currentWordWidth:Int = 0;
		
		for (i in 0...message.length)
		{
			var character:String = message.charAt(i);
			var charWidth:Int = Math.ceil(chatFont.getCharWidth(character.charCodeAt(0)));
			
			currentWord += character;
			currentWordWidth += charWidth;
			
			// Word ends! Evaluate that word, see if we can add it.
			if (character == " " || i == message.length - 1)
			{
				// Will adding this word to the line exceed the length?
				// No:
				if (currentLineWidth + currentWordWidth < MAX_LINE - 5)
				{
					currentLine += currentWord;
					currentLineWidth += currentWordWidth;
					
					currentWordWidth = 0;
					
					if (currentLineWidth + LINE_MARGIN > bubbleWidth)
					{
						bubbleWidth = currentLineWidth + LINE_MARGIN;
					}
				}
				
				// Yes:
				else
				{
					// Is this the longest line?
					// Yes:
					if (currentLineWidth + LINE_MARGIN > bubbleWidth)
					{
						bubbleWidth = currentLineWidth + LINE_MARGIN;
					}
					
					lines.push(currentLine);
					
					// Rollover into the next line.
					currentLine = currentWord;
					currentLineWidth = currentWordWidth;
				}
				
				currentWord = "";
				currentWordWidth = 0;
				
				continue;
			}
			
			// The word hasn't ended, but we already know this won't fit on a single line.
			else if (currentWordWidth >= MAX_LINE - 5)
			{
				if (currentLineWidth + LINE_MARGIN > bubbleWidth)
				{
					bubbleWidth = currentLineWidth + LINE_MARGIN;
				}
				
				else if (currentWordWidth + LINE_MARGIN > bubbleWidth)
				{
					bubbleWidth = currentWordWidth + LINE_MARGIN;
				}
				
				// Push the line, if it's not a reset line.
				if (currentLine != "")
				{
					lines.push(currentLine);
				}
				
				lines.push(currentWord);
				
				currentWord = "";
				currentWordWidth = 0;
				
				currentLine = "";
				currentLineWidth = 0;
			}
		}
		
		if (currentLineWidth + LINE_MARGIN > bubbleWidth)
		{
			bubbleWidth = currentLineWidth + LINE_MARGIN;
		}
		
		lines.push(currentLine);
		
		bubbleHeight = (lines.length) * 11;
	}
	
	private function generateBubble(speaker:String, gender:Int):Void
	{
		var borderHeight:Int = bubbleHeight - 10;
		var startX:Int = Math.ceil(((MAX_LINE + LINE_MARGIN + 30) / 2) - ((bubbleWidth + 30) / 2));
		makeGraphic(MAX_LINE + LINE_MARGIN + 30, bubbleHeight + 30, 0x00FFFFFF, true);
		
		var whiteStamp:FlxSprite = new FlxSprite(0, 0);
		whiteStamp.makeGraphic(bubbleWidth, bubbleHeight + 20, 0xFFFFFFFF, true);
		stamp(whiteStamp, startX + 15, 0);
		
		var marginStamp:FlxSprite = new FlxSprite(0, 0);
		marginStamp.makeGraphic(15, bubbleHeight - 5, 0xFFFFFFFF, true);
		
		stamp(marginStamp, startX, 12);
		stamp(marginStamp, startX + bubbleWidth + 15, 12); 
		
		// Construct the bubble.
		stamp(bubbleCorner, startX, 0);
		bubbleCorner.flipX = true;
		stamp(bubbleCorner, startX + bubbleWidth + 15, 0);
		bubbleCorner.flipY = true;
		stamp(bubbleCorner, startX + bubbleWidth + 15, bubbleHeight + 5);
		bubbleCorner.flipX = false;
		stamp(bubbleCorner, startX, bubbleHeight + 5);
		
		// Construct the borders.
		for (i in 0...borderHeight)
		{
			// Left side.
			this.pixels.setPixel(startX + 0, 15 + i, 0x01345C);
			this.pixels.setPixel(startX + 1, 15 + i, 0x92D0FF);
			this.pixels.setPixel(startX + 2, 15 + i, 0x92D0FF);
			this.pixels.setPixel(startX + 3, 15 + i, 0x46ABF8);
			
			// Right side.
			this.pixels.setPixel(startX + bubbleWidth + 29, 15 + i, 0x01345C);
			this.pixels.setPixel(startX + bubbleWidth + 28, 15 + i, 0x92D0FF);
			this.pixels.setPixel(startX + bubbleWidth + 27, 15 + i, 0x92D0FF);
			this.pixels.setPixel(startX + bubbleWidth + 26, 15 + i, 0x46ABF8);
		}
		
		for (i in 0...bubbleWidth)
		{
			// Top.
			this.pixels.setPixel(startX + 15 + i, 0, 0x01345C);
			this.pixels.setPixel(startX + 15 + i, 1, 0x92D0FF);
			this.pixels.setPixel(startX + 15 + i, 2, 0x92D0FF);
			this.pixels.setPixel(startX + 15 + i, 3, 0x46ABF8);
			
			this.pixels.setPixel(startX + 15 + i, bubbleHeight + 19, 0x01345C);
			this.pixels.setPixel(startX + 15 + i, bubbleHeight + 18, 0x92D0FF);
			this.pixels.setPixel(startX + 15 + i, bubbleHeight + 17, 0x92D0FF);
			this.pixels.setPixel(startX + 15 + i, bubbleHeight + 16, 0x46ABF8);
		}
		
		stamp(bubblePointer, startX + Math.ceil(((bubbleWidth + 30) / 2) - 7), Math.ceil(bubbleHeight + 16));
		
		for (i in 0...lines.length)
		{
			var chatText:FlxBitmapTextBlittable = new FlxBitmapTextBlittable(chatFont, true);
			chatText.color = 0xFF000000;
			chatText.antialiasing = false;
			chatText.pixelPerfectRender = false;
			chatText.text = lines[i];
			
			stamp(chatText, startX +  10, (i * 11) + 8);
		}
		
		var usernameText:FlxBitmapTextBlittable = new FlxBitmapTextBlittable(chatFont, true);
		usernameText.antialiasing = false;
		usernameText.color = 0xFF2077B9;
		usernameText.pixelPerfectRender = false;
		usernameText.text = speaker + ": ";
		stamp(usernameText, startX + 10, 8);
	}
}