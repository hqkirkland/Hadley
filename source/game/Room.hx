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

	private var itemMap:Dictionary<String, FlxPoint>;
	public var roomEntities:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
	
	public function new(_roomName:String, ?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		roomName = _roomName;
		
		this.loadGraphic("assets/images/rooms/" + roomName + "/" + roomName + ".png");
	}
	
	public function addAvatar(newAvatar:Avatar, x:Int=0, y:Int=0)
	{
		newAvatar.x = x;
		newAvatar.y = y;
		
		roomEntities.add(newAvatar);
	}
	
	public function addItem(graphicName:String, x:Int=0, y:Int=0)
	{
		var itemSprite:FlxSprite = new FlxSprite(x, y);		
		itemSprite.loadGraphic("assets/images/rooms/" + roomName + "/" + graphicName + ".png");
		
		var itemGraphics:GraphicsSheet = new GraphicsSheet(Std.int(itemSprite.width), Std.int(itemSprite.height));
		itemGraphics.drawItem(itemSprite.pixels);
		itemSprite.pixels = itemGraphics.bitmapData;
		
		roomEntities.add(itemSprite);
	}
	
	public function addMain(graphicName:String)
	{
		var itemSprite:FlxSprite = new FlxSprite();		
		itemSprite.loadGraphic("assets/images/rooms/" + roomName + "/" + graphicName + ".png");
		
		roomEntities.add(itemSprite);
	}
	
	public function sortGraphics()
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