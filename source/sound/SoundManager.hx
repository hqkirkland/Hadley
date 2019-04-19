package sound;

import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.system.FlxSoundGroup;

/**
 * ...
 * @author Hunter
 */

class SoundManager 
{
	public var currentRoom:String;
	public var currentSurface:Int;
	
	public var currentWalkSound:Int = -1;
	
	private var walkSoundGroup:FlxSoundGroup;
	
	public function new()
	{
		walkSoundGroup = new FlxSoundGroup();
		
		var woodWalk:FlxSound = FlxG.sound.load(AssetPaths.Step1__wav);
		woodWalk.looped = true;
		woodWalk.endTime = woodWalk.length - 75;
		woodWalk.loopTime = 50;
		
		var dirtWalk:FlxSound = FlxG.sound.load(AssetPaths.Step2__wav);
		dirtWalk.looped = true;
		dirtWalk.endTime = dirtWalk.length - 75;
		dirtWalk.loopTime = 50;
		
		var grassWalk:FlxSound = FlxG.sound.load(AssetPaths.Step3__wav);
		grassWalk.looped = true;
		grassWalk.endTime = grassWalk.length - 75;
		grassWalk.loopTime = 50;
		
		var stoneWalk:FlxSound = FlxG.sound.load(AssetPaths.Step4__wav);
		stoneWalk.looped = true;
		stoneWalk.endTime = stoneWalk.length - 75;
		stoneWalk.loopTime = 50;
		
		walkSoundGroup.add(woodWalk);
		walkSoundGroup.add(dirtWalk);
		walkSoundGroup.add(grassWalk);
		walkSoundGroup.add(stoneWalk);
		
		walkSoundGroup.volume = .50;
	}
	
	public function playWalkSound(isRunning:Bool):Void
	{
		var previousWalkSound:Int = currentWalkSound;
		
		switch (currentSurface)
		{
			// Wood
			case 0xFF663300: currentWalkSound = 0;
			// Dirt
			case 0xFFBC9D52: currentWalkSound = 1;
			// Grass
			case 0xFF57951C: currentWalkSound = 2;
			// Stone
			case 0xFFCEBEAD: currentWalkSound = 3;
			// None
			case 0xFF010101: currentWalkSound = -1;
			// None
			case 0x00000000: currentWalkSound = -1;
		}
		
		if (currentWalkSound != previousWalkSound)
		{
			if (currentWalkSound != -1 && previousWalkSound != -1)
			{
				walkSoundGroup.sounds[previousWalkSound].stop();
			}
		}
		
		// OLD: Why multiply the index by 3?
		// Because there's a bug in HaxeFlixel!
		// add()ing a sound to a FlxSoundGroup adds it 3 times!
		// So we need to make sure the index is x'd by 3.
		
		if (currentWalkSound == -1 && previousWalkSound != -1)
		{
			walkSoundGroup.sounds[previousWalkSound].stop();
		}
		
		else if (currentWalkSound != -1)
		{			
			walkSoundGroup.sounds[currentWalkSound].play();
		}
	}
	
	public static inline function setRadialSound(soundTarget:FlxSound, x:Float, y:Float, ?radius:Float)
	{
		soundTarget.proximity(x, y, FlxG.camera.target, FlxG.width * 0.5);
	}
}
