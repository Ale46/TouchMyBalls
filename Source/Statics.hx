package ;

import org.flixel.FlxState;
import org.flixel.FlxButton;
import org.flixel.FlxText;
import org.flixel.FlxG;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;

/**
 * ...
 * @author Ale46
 */
class Statics extends FlxState {
	
	public function new () {
		
		super();
		
	}		
	
		override public function create():Void{
		
		var back:FlxSprite = new FlxSprite(0,0,"statics");
		back.scrollFactor.x = back.scrollFactor.y = 0;
		add(back);
		var saveScore:FlxSave = new FlxSave();
		
		var startButton:FlxButton = new FlxButton(FlxG.width / 2 - 20, FlxG.height - 84, "Go Back", onClick);
		
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
		var hgtext:FlxText = new FlxText(FlxG.width / 3 - 65, 130,350);
		var timetext:FlxText = new FlxText(FlxG.width / 3 - 65, 250,350);
		var playtext:FlxText = new FlxText(FlxG.width / 3 - 65, 190,250);
		var ballstext:FlxText = new FlxText(FlxG.width / 3 - 65, 220,250);
		var hgatext:FlxText = new FlxText(FlxG.width / 3 - 65, 160,350);
		hgatext.size = hgtext.size = timetext.size = playtext.size = ballstext.size = 12;
		
		if(saveScore.bind("Mode"))
		{
			if(saveScore.data == null){
				hgtext.text = "No data! Go to play!";
			}else{
				hgtext.text = "High Score (LevelMode): "+saveScore.data.hg;
				hgatext.text = "High Score (ArcadeMode): "+saveScore.data.hga;
				var time:String = Std.string(saveScore.data.time);
				timetext.text = "Total Time played: "+ time.substr(0,(time.indexOf(".")+2));
				playtext.text = "Level played: "+saveScore.data.plays;
				ballstext.text = "Total balls touched: "+saveScore.data.balls;
				
			}
			//trace("Number of highscores: "+TouchMyBall.saveScore.data.hg);
		}
		add(hgtext);
		add(hgatext);
		add(timetext);
		add(playtext);
		add(ballstext);
		
	}		
	
	public function onClick(): Void{
		FlxG.switchState(new MenuState());
	}

}
