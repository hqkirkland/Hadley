package game;

import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.Object;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxTileFrames;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

import game.BubbleStack;

/**
 * ...
 * @author ...
 */

typedef AvatarItem =
{
	var gameItem:ClothingItem;
	var assetPath:String;
	var itemColor:Int;
}

class Avatar extends FlxSprite 
{
	public var username:String;
	public var country:String;
	
	// TODO: Convert to some kind of object w/ attribute for each body piece.
	// Also attribute for each piece color.
	// ACTUALLY: Maybe not? Doing that would make it harder to iterate..
	public var itemArray:Array<AvatarItem>;
	
	public var canWalk:Bool = true;
	public var currentAction:String = "Stand";
	public var previousAction:String = "";
	public var currentDirection:String = "South";
	public var enableWalk:Bool = true;
	public var fadeComplete:Bool = false;
	public var isHolding:Bool = false;

	public var velocityX:Float = 0;
	public var velocityY:Float = 0;
	public var playerNextMovement:FlxPoint = FlxPoint.get(0, 0);
	
	public var chatGroup:BubbleStack;
	
	//public var chatBubbles:FlxTypedSpriteGroup<Chatbubble>;
	
	public var keysTriggered:Object = { North: false, South: false, East: false, West: false, Run: false };
	public var previousKeysTriggered:Object = { North: false, South: false, East: false, West: false, Run: false };
	
	public var overlapRectangle:FlxObject = new FlxObject(0, 0, 10, 10);
	
	public static var actionSet:Object = { Stand: "Stand", Walk: "Walk", Sit: "Sit", Hold: "Hold" };
	public static var directionSet:Object = { North: "North", South: "South", East: "East", West: "West" };
	
	private var avatarSheet:GraphicsSheet = new GraphicsSheet(1772, 68);
	
	// TODO: Make zeroPoint, frameSizePoint, sheetRect constants in constants Class.
	private static var frameSizePoint:FlxPoint = new FlxPoint(41, 68);
	private static var sheetRect:Rectangle = new Rectangle(0, 0, 1722, 68);
	
	// (This too) It saves CPU to pre-determine velocities rather than calculate them every frame.
	private static var orthogVelocity:FlxPoint = new FlxPoint(96, 48);
	private static var diagVelocity:FlxPoint = new FlxPoint(92.3, 26);
	
	public function new(_username:String) 
	{
		super();
		username = _username;
		chatGroup = new BubbleStack(username);

		// TODO: Create figure object, or create typedef for clothing objects.
	}
	
	public function setAppearance(appearanceString:String):Void
	{
		avatarSheet = new GraphicsSheet(1772, 68);
		itemArray = new Array<AvatarItem>();
		var figure:Array<String> = appearanceString.split('^');
		
		for (i in 0...8)
		{
			var gameItemKey:Int = Std.parseInt(figure[i * 2]);
			
			// 4 needs to be a slot strictly reserved for the back of 2-part hats.
			if (i == 4)
			{
				itemArray.push(null);
			}
			
			if (gameItemKey == 0 || !ClientData.clothingItems.exists(gameItemKey))
			{
				itemArray.push(null);
				continue;
			}
			
			var item:AvatarItem = {
				gameItem: ClientData.clothingItems[gameItemKey], 
				assetPath: Std.string(gameItemKey),
				itemColor: Std.parseInt(figure[(i * 2) + 1])
			};
			
			itemArray.push(item);
			MasterInventory.addItemById(item.gameItem.gameItemId);
			
			// This is the hat! Since there's a piece behind the hat, there's an extra step!
			// Need to figure out which position the other clothing items should be placed, if 'layered'
			if (item.gameItem.layered && i == 7)
			{
				var layerItem:AvatarItem = {
					gameItem: ClientData.clothingItems[gameItemKey],
					assetPath: ClientData.clothingItems[gameItemKey].layeredAsset,
					itemColor: Std.parseInt(figure[(i * 2) + 1])
				};
				
				itemArray[4] = layerItem;
			}
		}
		
		this.pixels = new BitmapData(41, 68, true, 0x00000000);
		
		this.alpha = 0;
		generateAvatar();
		generateAnimation();
		fadeIn();
		
		this.alpha = 1;
		
		this.width = 10;
		this.height = 5;
	}
	
	private function generateAvatar():Void
	{
		var itemSprite:FlxSprite = new FlxSprite(0, 0);
		
		for (item in itemArray)
		{
			if (item == null)
			{
				continue;
			}
			
			itemSprite.loadGraphic("assets/items/" + item.assetPath + ".png");
			
			itemSprite.pixels = GraphicsSheet.colorItem(itemSprite.pixels, item.itemColor, item.gameItem.colorType);			
			avatarSheet.drawItem(itemSprite.pixels);
		}
	}
	
	private function generateAnimation():Void
	{
		this.frames = FlxTileFrames.fromGraphic(FlxGraphic.fromBitmapData(avatarSheet.bitmapData), frameSizePoint);
		
		animation.add("StandNorth", [0], 0, false, false);
		animation.add("StandNorthEast", [1], 0, false, false);
		animation.add("StandEast", [2], 0, false, false);
		animation.add("StandSouthEast", [3], 0, false, false);
		animation.add("StandSouth", [4], 0, false, false);
		
		animation.add("StandNorthWest", [1], 0, false, true);
		animation.add("StandWest", [2], 0, false, true);
		animation.add("StandSouthWest", [3], 0, false, true);
		
		animation.add("HoldNorth", [37], 0, false, false);
		animation.add("HoldNorthEast", [38], 0, false, false);
		animation.add("HoldEast", [39], 0, false, false);
		animation.add("HoldSouthEast", [40], 0, false, false);
		animation.add("HoldSouth", [41], 0, false, false);
		
		animation.add("HoldNorthWest", [38], 0, false, true);
		animation.add("HoldWest", [39], 0, false, true);
		animation.add("HoldSouthWest", [40], 0, false, true);
		
		animation.add("WalkNorth", [5, 6, 7, 8, 9, 10], 10, true, false);
		animation.add("WalkSouth", [29, 30, 31, 32, 33, 34], 10, true, false);
		
		animation.add("WalkNorthEast", [11, 12, 13, 14, 15, 16], 10, true, false);
		animation.add("WalkEast", [17, 18, 19, 20, 21, 22], 10, true, false);
		animation.add("WalkSouthEast", [23, 24, 25, 26, 27, 28], 10, true, false);
		
		animation.add("WalkNorthWest", [11, 12, 13, 14, 15, 16], 10, true, true);
		animation.add("WalkWest", [17, 18, 19, 20, 21, 22], 10, true, true);
		animation.add("WalkSouthWest", [23, 24, 25, 26, 27, 28], 10, true, true);
		
		animation.add("SitSouthWest", [35], 0, false, true);
		animation.add("SitNorthWest", [36], 0, false, true);
		animation.add("SitSouthEast", [35], 0, false, false);
		animation.add("SitNorthEast", [36], 0, false, false);
		
		this.offset = FlxPoint.get(15, 63);
		//this.offset.set(15, 63);
		//this.offset.x = 15;
		//this.offset.y = 63;
	}
	
	override public function update(elapsed:Float):Void
	{
		doAnimation();
		super.update(elapsed);
		
		chatGroup.x = (this.x - this.offset.x) + ((this.frameWidth / 2) - (this.chatGroup.width / 2));
		chatGroup.y = Math.ceil(this.y - this.frameHeight);
    }
	
	private function doAnimation():Void
	{
		var animationString:String = buildAnimationString();
		
		animation.play(animationString);
		
		if (previousKeysTriggered.Run) 
		{ this.velocity = FlxPoint.get(this.velocityX * 1.66, this.velocityY * 1.66); }
		else
		{ this.velocity = FlxPoint.get(this.velocityX, this.velocityY); }
		
		this.velocity.put();
		chatGroup.velocity = this.velocity;
	}
	
	public function smoothMovement():Void
	{
		// X is R
		// Y is L
		// South means SWITCH SHIFTS of L and R.
		
		previousAction = currentAction;
		
		if (playerNextMovement.x == 1 && playerNextMovement.y == 1)
		{
			this.velocityX = 0;
			this.velocityY = 0;
			this.velocity = FlxPoint.get(0, 0);
			this.canWalk = false;
			return;
		}
		
		this.canWalk = true;
		
		if (keysTriggered.North && keysTriggered.East)
		{
			if (playerNextMovement.x == 1)
			{
				this.velocityX = 0;
				this.velocity.set(0, this.velocityY);
				this.x -= 3;
			}
			
			else if (playerNextMovement.y == 1)
			{
				this.velocityX = 0;
				this.velocity.set(0, this.velocityY);
				this.x += 3;
			}
		}
		
		else if (keysTriggered.South && keysTriggered.West)
		{
			if (playerNextMovement.x == 1)
			{
				this.velocityX = 0;
				this.velocity.set(0, this.velocityY);
				this.x += 2;
			}
			
			else if (playerNextMovement.y == 1)
			{
				this.velocityX = 0;
				this.velocity.set(0, this.velocityY);
				this.x -= 3;
			}
		}
		
		else if (keysTriggered.South && keysTriggered.East)
		{
			if (playerNextMovement.x == 1)
			{
				this.velocityX = 0;
				this.velocity.set(0, this.velocityY);
				this.x += 2;
			}
			
			else if (playerNextMovement.y == 1)
			{
				this.velocityX = 0;
				this.velocity.set(0, this.velocityY);
				this.x -= 3;
			}
		}
		
		else if (keysTriggered.North && keysTriggered.West)
		{
			if (playerNextMovement.x == 1)
			{
				this.velocityX = 0;
				this.velocity.set(0, this.velocityY);
				this.x -= 1;
			}
			
			else if (playerNextMovement.y == 1)
			{
				this.velocityX = 0;
				this.velocity.set(0, this.velocityY);
				this.x += 3;
			}
		}
		
		else if (keysTriggered.East)
		{
			if (playerNextMovement.x == 1)
			{
				this.velocityY = 0;
			}
			
			if (playerNextMovement.y == 1)
			{
				this.velocityY = 0;
			}
		}
		
		else if (keysTriggered.West)
		{
			if (playerNextMovement.x == 1)
			{
				this.velocityY = 0;
			}
			
			if (playerNextMovement.y == 1)
			{
				this.velocityY = 0;
			}
		}
	}
	
	private function buildAnimationString():String
	{
		currentAction = actionSet.Stand;
		
		if (!enableWalk)
		{
			this.velocityX = 0;
			this.velocityY = 0;
			return currentAction + currentDirection;
		}
		
		if (keysTriggered.North && keysTriggered.East) 
		{
			previousKeysTriggered.North = true;
			previousKeysTriggered.South = false;
			
			previousKeysTriggered.East = true;
			previousKeysTriggered.West = false;
			
			if (canWalk)
			{
				currentAction = actionSet.Walk;
				currentDirection = directionSet.North + directionSet.East;
				
				this.velocityX = diagVelocity.x;
				this.velocityY = diagVelocity.y * -1;
			}
		}
		
		else if (keysTriggered.North && keysTriggered.West)
		{
			previousKeysTriggered.North = true;
			previousKeysTriggered.South = false;
			
			previousKeysTriggered.East = false;
			previousKeysTriggered.West = true;
			
			if (canWalk)
			{
				currentAction = actionSet.Walk;
				currentDirection = directionSet.North + directionSet.West;
				
				this.velocityX = diagVelocity.x * -1;
				this.velocityY = diagVelocity.y * -1;
			}
		}
		
		else if (keysTriggered.South && keysTriggered.East)
		{			
			previousKeysTriggered.North = false;
			previousKeysTriggered.South = true;
			
			previousKeysTriggered.East = true;
			previousKeysTriggered.West = false;
			
			if (canWalk)
			{
				currentAction = actionSet.Walk;
				currentDirection = directionSet.South + directionSet.East;
				
				this.velocityX = diagVelocity.x;
				this.velocityY = diagVelocity.y;
			}
		}
		
		else if (keysTriggered.South && keysTriggered.West)
		{
			previousKeysTriggered.North = false;
			previousKeysTriggered.South = true;
			
			previousKeysTriggered.East = false;
			previousKeysTriggered.West = true;
			
			if (canWalk)
			{
				currentAction = actionSet.Walk;
				currentDirection = directionSet.South + directionSet.West;
				
				this.velocityX = diagVelocity.x * -1;
				this.velocityY = diagVelocity.y;
			}
		}
		
		else if (keysTriggered.East)
		{			
			previousKeysTriggered.North = false;
			previousKeysTriggered.South = false;
			
			previousKeysTriggered.East = true;
			previousKeysTriggered.West = false;
			
			if (canWalk)
			{
				currentAction = actionSet.Walk;
				currentDirection = directionSet.East;
				
				this.velocityX = orthogVelocity.x;
				this.velocityY = 0;
			}
		}
		
		else if (keysTriggered.West)
		{
			previousKeysTriggered.North = false;
			previousKeysTriggered.South = false;
			
			previousKeysTriggered.East = false;
			previousKeysTriggered.West = true;
			
			if (canWalk)
			{
				currentAction = actionSet.Walk;
				currentDirection = directionSet.West;
				
				this.velocityX = orthogVelocity.x * -1;
				this.velocityY = 0;
			}
		}
		
		else if (keysTriggered.South)
		{			
			previousKeysTriggered.North = false;
			previousKeysTriggered.South = true;
			
			previousKeysTriggered.East = false;
			previousKeysTriggered.West = false;
			
			if (canWalk)
			{
				currentAction = actionSet.Walk;
				currentDirection = directionSet.South;
				
				this.velocityX = 0;
				this.velocityY = orthogVelocity.y;
			}
		}
		
		else if (keysTriggered.North)
		{
			previousKeysTriggered.North = true;
			previousKeysTriggered.South = false;
			
			previousKeysTriggered.East = false;
			previousKeysTriggered.West = false;
			
			if (canWalk)
			{
				currentAction = actionSet.Walk;
				currentDirection = directionSet.North;
				
				this.velocityX = 0;
				this.velocityY = orthogVelocity.y * -1;
			}
		}
		
		else
		{
			this.velocityX = 0;
			this.velocityY = 0;
			
			// Both Sit and Walk have animations baked into the sheets, for holding.
			// This check may be unnecessary, since keysTriggered indicates walking.
			if (currentAction != actionSet.Sit || currentAction != actionSet.Walk)
			{
				if (isHolding) { currentAction = actionSet.Hold; }
				else { currentAction = actionSet.Stand; }
			}
			
			if (previousKeysTriggered.North && previousKeysTriggered.East) 
			{ currentDirection = directionSet.North + directionSet.East; }
			
			else if (previousKeysTriggered.North && previousKeysTriggered.West)
			{ currentDirection = directionSet.North + directionSet.West; }
			
			else if (previousKeysTriggered.South && previousKeysTriggered.East)
			{ currentDirection = directionSet.South + directionSet.East; }
			
			else if (previousKeysTriggered.South && previousKeysTriggered.West)
			{ currentDirection = directionSet.South + directionSet.West; }
			
			else if (previousKeysTriggered.East)
			{ currentDirection = directionSet.East; }
			
			else if (previousKeysTriggered.West)
			{ currentDirection = directionSet.West; }
			
			else if (previousKeysTriggered.South)
			{ currentDirection = directionSet.South; }
			
			else if (previousKeysTriggered.North)
			{ currentDirection = directionSet.North; }
		}
		
		previousKeysTriggered.Run = keysTriggered.Run;		
		
		return currentAction + currentDirection;
	}
	
	public function leaveRoom():Void
	{
		enableWalk = false;
		
		fadeAway();
		
		previousKeysTriggered.North = false;
		previousKeysTriggered.South = false;
		previousKeysTriggered.East = false;
		previousKeysTriggered.West = false;
		
		chatGroup.clear();
		chatGroup = new BubbleStack(this.username);
	}
	
	public function fadeAway():Void
	{
		FlxTween.tween(this, { alpha: 0 }, 0.5, { ease: FlxEase.smoothStepIn, onComplete: 
		{
			function(_) 
			{
				fadeComplete = true;
			}
		}
		});
	}
	
	public function fadeIn():Void
	{
		FlxTween.tween(this, { alpha: 1 }, 0.5, { ease: FlxEase.smoothStepIn, onComplete: 
		{
			function(_)
			{
				enableWalk = true;
				fadeComplete = false;
			}
		}});
	}
	
	public function isWearingItem(checkedItem:ClothingItem):Bool
	{
		switch (checkedItem.itemType)
		{
			case ClothingType.HAT:
				if (itemArray[8] != null)
				{
					return itemArray[8].gameItem.gameItemId == checkedItem.gameItemId;
				}
			case ClothingType.GLASSES:
				if (itemArray[7] != null)
				{
					return itemArray[7].gameItem.gameItemId == checkedItem.gameItemId;
				}
			case ClothingType.SHIRT:
				if (itemArray[3] != null)
				{
					return itemArray[3].gameItem.gameItemId == checkedItem.gameItemId;
				}
			case ClothingType.PANTS:
				if (itemArray[2] != null)
				{
					return itemArray[2].gameItem.gameItemId == checkedItem.gameItemId;
				}
			case ClothingType.SHOES:
				if (itemArray[1] != null)
				{
					return itemArray[1].gameItem.gameItemId == checkedItem.gameItemId;
				}
		}
		
		return false;
	}
}