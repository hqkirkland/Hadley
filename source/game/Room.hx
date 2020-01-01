package game;

import haxe.Json;

import openfl.Assets;
import openfl.display.BitmapData;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSort;

import game.Avatar;

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
	var portals:Array<RoomPortal>;
}

typedef RoomPart = {
	var type:String;
	var asset:String;
	var x:Int;
	var y:Int;
	var frameCount:Int;
	@:optional var maskX:Int;
	@:optional var maskY:Int;
	@:optional var frequency:Int;
}

typedef RoomPortal = {
	var asset:String;
	var x:Int;
	var y:Int;
	var frameCount:Int;
	var nextRoom:String;
	var entryDirection:String;
	var exitDirections:Array<String>;
	var setX:Int;
	var setY:Int;
}

class Room extends FlxSprite
{
	public var roomName:String;
	
	public var roomEntities:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
	public var portalEntities:FlxTypedSpriteGroup<Portal> = new FlxTypedSpriteGroup<Portal>();
	public var vehicleEntities:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
	
	public var walkMap:FlxSprite;
	public var roomReady:Bool = false;
	public var backgroundColor:FlxColor;
	
	public var grid:RoomGrid = new RoomGrid(0, 0);
	
	public function new(_roomName:String, ?X:Float=0, ?Y:Float=0) 
	{
		// This function should get passed a dictionary of items from parsed manifest.
		super(X, Y);
		roomName = _roomName;
		walkMap = new FlxSprite();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		sortGraphics();
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
			var partSprite:FlxSprite = generateItem(currentPart.asset, currentPart.x, currentPart.y, currentPart.frameCount);
			
			if (currentPart.type == "elevator")
			{
				// Definitely need custom class for vehicle.
				var maskSprite:FlxSprite = generateItem(currentPart.asset + "_mask", currentPart.maskX, currentPart.maskY);
				
				var toX:Float = partSprite.x;
				var toY:Float = partSprite.y - (partSprite.height * 1.66);
				
				FlxTween.tween(partSprite, { x: toX, y: toY }, 3, { type: FlxTweenType.PINGPONG, ease: FlxEase.smootherStepInOut, startDelay: 2, loopDelay: 3 });
				
				vehicleEntities.add(partSprite);
				vehicleEntities.add(maskSprite);
			}
			
			else
			{
				roomEntities.add(partSprite);
			}
		}
		
		for (i in 0...objectStructure.portals.length)
		{
			var currentPortal:RoomPortal = objectStructure.portals[i];
			
			var portalBmp:BitmapData = Assets.getBitmapData(roomName + ":assets/" + roomName + "/images/" + currentPortal.asset + ".png");
			var startDirection:String = currentPortal.entryDirection;
			var exitDirections:Array<String> = currentPortal.exitDirections;
			var nextRoom:String = currentPortal.nextRoom;
			var setX:Int = currentPortal.setX;
			var setY:Int = currentPortal.setY;
			
			var portalSprite:Portal = new Portal(portalBmp, startDirection, exitDirections, nextRoom, setX, setY, currentPortal.x, currentPortal.y);
			portalSprite.isDefault = portalEntities.length == 0;
			portalSprite.visible = false;
			
			portalEntities.add(portalSprite);
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
		if (this.walkMap.pixels != null)
		{
			return this.walkMap.pixels.getPixel32(Std.int(nx - walkMap.x), Std.int(ny - walkMap.y));
		}
		
		return 0;
	}
	
	public function sortGraphics():Void
	{
		roomEntities.sort(byDepth, FlxSort.ASCENDING);
		return;
	}

	private static inline function byDepth(Order:Int, Obj1:FlxObject, Obj2:FlxObject):Int
	{
		var ay:Float = Obj1.y + Obj1.height;
		var by:Float = Obj2.y + Obj2.height;
		
		return FlxSort.byValues(Order, ay, by);
	}
}