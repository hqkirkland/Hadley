package game;

import flixel.util.FlxColor;
import game.Avatar;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxSort;
import haxe.Json;
import openfl.Assets;
import openfl.display.BitmapData;

/**
 * ...
 * @author Hunter
 */ 

typedef RoomStructure = {
	var name:String;
	var walkMapX:Int;
	var walkMapY:Int;
	var background:String;
	var parts:Array<RoomPart>;
}

typedef RoomPart = {
	var type:String;
	var asset:String;
	var x:Int;
	var y:Int;
	var frameCount:Int;
	@:optional var nextRoom:String;
	@:optional var isDefault:Bool;
	@:optional var entryDirection:String;
	@:optional var exitDirections:Array<String>;
	@:optional var setX:Int;
	@:optional var setY:Int;
}

class Room extends FlxSprite
{
	public var roomName:String;

	public var roomEntities:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
	public var portalEntities:FlxTypedSpriteGroup<Portal> = new FlxTypedSpriteGroup<Portal>();	
	public var walkMap:FlxSprite;
	public var roomReady:Bool = false;
	public var backgroundColor:FlxColor;
	
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
		var objectStructure:RoomStructure = Json.parse(roomStruct);
		
		walkMap.loadGraphic(roomName + ":assets/" + roomName + "/images/" + roomName + "_map.png");
		walkMap.x = this.x + objectStructure.walkMapX;
		walkMap.y = this.y + objectStructure.walkMapY;
		
		var bgColor:Int = Std.parseInt(objectStructure.background);
		backgroundColor = new FlxColor(bgColor);
		
		for (i in 0...objectStructure.parts.length)
		{
			var currentPart:RoomPart = objectStructure.parts[i];
			
			if (currentPart.type == "object")
			{
				var partSprite:FlxSprite = generateItem(currentPart.asset, currentPart.x, currentPart.y, currentPart.frameCount);
				roomEntities.add(partSprite);
			}
			
			else if (currentPart.type == "portal")
			{
				var portalBmp:BitmapData = Assets.getBitmapData(roomName + ":assets/" + roomName + "/images/" + currentPart.asset + ".png");
				var startDirection:String = currentPart.entryDirection;
				var exitDirections:Array<String> = currentPart.exitDirections;
				var nextRoom:String = currentPart.nextRoom;
				var setX:Int = currentPart.setX;
				var setY:Int = currentPart.setY;
				
				var portalSprite:Portal = new Portal(portalBmp, startDirection, exitDirections, nextRoom, setX, setY, currentPart.x, currentPart.y);
				portalSprite.isDefault = portalEntities.length == 0;
				
				portalEntities.add(portalSprite);
			}
		}
		
		roomReady = true;
	}
	
	public function generateItem(graphicName:String, x:Int=0, y:Int=0, frameCount:Int=0):FlxSprite
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
			
			itemSprite.animation.add("Animation", [for (i in 0...frameCount) i], 9, true);
			itemSprite.animation.play("Animation");
		}
		
		return itemSprite;
	}
	
	public function addAvatar(newAvatar:Avatar, exitRoom:String=""):Void
	{
		var portalId:Int = findPortal(exitRoom);
		var entryPortal:Portal = portalEntities.group.members[portalId];
		
		newAvatar.x = this.x + entryPortal.setX + newAvatar.offset.x;
		newAvatar.y = this.y + entryPortal.setY + newAvatar.offset.y;
		
		newAvatar.currentDirection = entryPortal.startDirection;
		
		roomEntities.add(newAvatar);
		
		newAvatar.fadeIn();
	}
	
	private function findPortal(fromRoom:String):Int
	{
		var findDefault:Bool = fromRoom == "";
		
		if (findDefault)
		{
			for (i in 0...portalEntities.group.members.length)
			{
				if (portalEntities.group.members[i].isDefault)
				{
					return i;
				}
			}
		}
		
		else
		{
			for (i in 0...portalEntities.group.members.length)
			{
				if (portalEntities.group.members[i].nextRoom == fromRoom)
				{
					return i;
				}
			}
		}
		
		return 0;
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