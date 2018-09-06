package game;

import game.Avatar;
import haxe.Json;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxSort;
import openfl.Assets;

/**
 * ...
 * @author Hunter
 */ 

typedef RoomStructure = {
	public var name:String;
	public var parts:Array<RoomPart>;
}

typedef RoomPart = {
	public var asset:String;
	public var x:Int;
	public var y:Int;
	public var frameCount:Int;
}

class Room extends FlxSprite
{
	public var roomName:String;

	public var roomEntities:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
	public var walkMap:FlxSprite;
	public var roomReady:Bool = false;

	public function new(_roomName:String, ?X:Float=0, ?Y:Float=0) 
	{
		// This function should get passed a dictionary of items from parsed manifest.
		super(X, Y);
		roomName = _roomName;

		walkMap = new FlxSprite();
	}
	
	public function generateRoom(roomStruct:String):Void
	{		
		this.loadGraphic(roomName + ":assets/" + roomName + "/images/" + roomName + ".png");
		
		walkMap.loadGraphic(roomName + ":assets/" + roomName + "/images/" + roomName + "_map.png");
		walkMap.x = this.x + 20;
		walkMap.y = this.y + 175;
		
		var objectStructure:RoomStructure = Json.parse(roomStruct);
		
		for (i in 0...objectStructure.parts.length)
		{
			var currentPart:RoomPart = objectStructure.parts[i];
			
			generateItem(currentPart.asset, currentPart.x, currentPart.y, currentPart.frameCount);
		}
		
		roomReady = true;
	}
	
	public function generateItem(graphicName:String, x:Int=0, y:Int=0, frameCount:Int=0):Void
	{
		var itemSprite:FlxSprite = new FlxSprite(this.x + x, this.y + y);
		itemSprite.loadGraphic(roomName + ":assets/" + roomName + "/images/" + graphicName + ".png");
		
		var itemGraphics:GraphicsSheet = new GraphicsSheet(Std.int(itemSprite.width), Std.int(itemSprite.height));		
		itemGraphics.drawItem(itemSprite.pixels);
		
		// If frameCount = 0, object has single frame.		
		if (frameCount > 1)
		{
			var frameSize:FlxPoint = new FlxPoint(itemSprite.width / frameCount, itemSprite.height);
			
			itemSprite.frames = FlxTileFrames.fromGraphic(FlxGraphic.fromBitmapData(itemGraphics.bitmapData), frameSize);
			
			itemSprite.animation.add("Animation", [for (i in 0...frameCount) i], 3, true);
			itemSprite.animation.play("Animation");
		}
		
		roomEntities.add(itemSprite);
	}
	
	public function addAvatar(newAvatar:Avatar, x:Int=0, y:Int=0):Void
	{
		newAvatar.x = this.x + x;
		newAvatar.y = this.y + y;
		
		roomEntities.add(newAvatar);
	}


	public function testWalkmap(nx:Float, ny:Float):Int
	{
		return this.walkMap.pixels.getPixel32(Std.int(nx - walkMap.x), Std.int(ny - walkMap.y));
	}
	
	public function sortGraphics():Void
	{
		roomEntities.sort(byDepth, FlxSort.ASCENDING);
	}
	
	private static inline function byDepth(Order:Int, Obj1:FlxObject, Obj2:FlxObject):Int
	{
		var ay:Float = Obj1.y + Obj1.height;
		var by:Float = Obj2.y + Obj2.height;
		
		return FlxSort.byValues(Order, ay, by);
	}
}