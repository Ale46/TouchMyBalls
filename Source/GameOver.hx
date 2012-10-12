package ;
import org.flixel.FlxState;
import org.flixel.FlxButton;
import org.flixel.FlxText;
import org.flixel.FlxG;
import flash.events.Event;
import org.flixel.FlxSprite;
/**
 * ...
 * @author Ale46
 */
class GameOver extends FlxState {
	
	public function new () {
		super();
	}
	
	override public function create():Void{
		
		var back:FlxSprite = new FlxSprite(0,0,"gameover");
		back.scrollFactor.x = back.scrollFactor.y = 0;
		add(back);
		
		
		var startButton:FlxButton = new FlxButton(FlxG.width / 2 - 20, FlxG.height - 84, "Restart level", onClick);
		
		#if !neko
		//startButton.color = 0x666699;
		startButton.label.color = 0x9999ff;
		#else
		startButton.color = { rgb: 0x666699, a: 0xff };
		startButton.label.color = { rgb: 0x9999ff, a: 0xff };
		#end
		startButton.scale.x = startButton.scale.y = 2;
		add(startButton);
		#if !mobile
		FlxG._game.useSystemCursor = true;
		#end
		var msg:FlxText = new FlxText(FlxG.width / 3 - 65, 210,350, "You failed. But you can restart the level! You will only loose all your points and a bit of honor.");
		msg.size = 12;
/*		if(TouchMyBall.saveScore.bind("Mode"))
		{
			if(TouchMyBall.saveScore.data.hg == null)
				TouchMyBall.saveScore.data.hg = FlxG.score;
			else if (TouchMyBall.saveScore.data.hg < FlxG.score )
				TouchMyBall.saveScore.data.hg = FlxG.score;
			//trace("Number of highscores: "+TouchMyBall.saveScore.data.hg);
		}*/
		
		add(msg);
		
	}		
	
		public function onClick () : Void {
		FlxG.score = 0;
		FlxG.switchState(new TouchMyBall(TouchMyBall.currentLevel));

	}

}
