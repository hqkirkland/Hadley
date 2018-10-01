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
		woodWalk.endTime = woodWalk.length - 100;
		woodWalk.loopTime = 50;
		walkSoundGroup.add(woodWalk);
		walkSoundGroup.volume = .50;
		
		// stoneWalk = loadWavSound(AssetPaths.StepX__wav);
		// stoneWalk.looped = true;
		// walkSoundGroup.add(stoneWalk);
	}
	
	public function playWalkSound(isRunning:Bool):Void
	{
		var previousWalkSound:Int = currentWalkSound;
		
		switch (currentSurface)
		{
			case 0xFF663300: currentWalkSound = 0;
			case 0xFF010101: currentWalkSound = -1;
			case 0x00000000: currentWalkSound = -1;
		}
		
		// Why multiply the index by 3?
		// Because there's a bug in HaxeFlixel!
		// add()ing a sound to a FlxSoundGroup adds it 3 times!
		// So we need to make sure the index is x'd by 3.
		if (currentWalkSound == -1 && previousWalkSound != -1)
		{
			walkSoundGroup.sounds[previousWalkSound * 3].stop();
		}
		
		else if (currentWalkSound != -1)
		{
			walkSoundGroup.sounds[currentWalkSound * 3].play();
		}
	}
	
	public static inline function setRadialSound(soundTarget:FlxSound, x:Float, y:Float, ?radius:Float)
	{
		soundTarget.proximity(x, y, FlxG.camera.target, FlxG.width * 0.5);
	}
}
