package ;

import flash.display.StageDisplayState;
import flash.system.Capabilities;
import org.flixel.FlxG;
import org.flixel.FlxCamera;
import org.flixel.FlxState;
/**
 * ...
 * @author Ale46
 */
class SetUpScreen  extends FlxState  {
	
	public function new () {
		
			FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;
		
		//	FlxG.stage.stageHeight = Std.int( Capabilities.screenResolutionY );
		//	FlxG.stage.stageWidth = Std.int(Capabilities.screenResolutionX);
			FlxG.width = Std.int(FlxG.stage.stageWidth / FlxCamera.defaultZoom);
            FlxG.height = Std.int(FlxG.stage.stageHeight / FlxCamera.defaultZoom);
            super();
		
	}		

	override public function update():Void 
		{
			FlxG.switchState(new MenuState());
			
		}

}
