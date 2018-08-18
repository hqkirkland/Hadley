package game;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxSort;
import openfl.utils.Dictionary;

/**
 * ...
 * @author Hunter
 */
class Room extends FlxSprite
{
	private var roomName:String;

	public var roomEntities:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
	public var walkMap:FlxSprite;
	
	public var gridMap:Array<Array<Int>>;
	
	public function new(_roomName:String, ?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		roomName = _roomName;
		
		walkMap = new FlxSprite();
		walkMap.loadGraphic("assets/images/rooms/" + roomName + "/" + roomName + "_map.png");
		walkMap.x = 20;
		walkMap.y = 175;
		
		this.loadGraphic("assets/images/rooms/" + roomName + "/" + roomName + ".png");
	}
	
	public function addAvatar(newAvatar:Avatar, x:Int=0, y:Int=0):Void
	{
		newAvatar.x = x;
		newAvatar.y = y;
		
		roomEntities.add(newAvatar);
	}
	
	public function addItem(graphicName:String, x:Int=0, y:Int=0):Void
	{
		var itemSprite:FlxSprite = new FlxSprite(x, y);		
		itemSprite.loadGraphic("assets/images/rooms/" + roomName + "/" + graphicName + ".png");
		
		var itemGraphics:GraphicsSheet = new GraphicsSheet(Std.int(itemSprite.width), Std.int(itemSprite.height));
		itemGraphics.drawItem(itemSprite.pixels);
		itemSprite.pixels = itemGraphics.bitmapData;
		
		roomEntities.add(itemSprite);
	}
	
	public function addMain(graphicName:String):Void
	{
		var itemSprite:FlxSprite = new FlxSprite();	
		itemSprite.loadGraphic("assets/images/rooms/" + roomName + "/" + graphicName + ".png");
		
		roomEntities.add(itemSprite);
	}
	
	public function testWalkmap(nx:Float, ny:Float):Int
	{
		return this.walkMap.pixels.getPixel(Std.int(nx - walkMap.x), Std.int(ny - walkMap.y));
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