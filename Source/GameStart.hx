package;

import org.flixel.FlxGame;
import org.flixel.FlxG;
/**
 * ...
 * @author Ale46
 */

class GameStart extends FlxGame
{

	public function new() 
	{
		#if !mobile
		super(640, 480, MenuState, 1,60,60,true);
		#else
		super(100, 100, SetUpScreen, 1,60,60);
		#end
		//this.forceDebugger = true;
		
	}
	
}