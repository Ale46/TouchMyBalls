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
class NextLevel extends FlxState {
	
	var arcade:Int;
	var timeSaved:Int;
	public function new (arcade:Int, timeSaved:Int = 0) {
		this.arcade = arcade;
		this.timeSaved = timeSaved;
		super();
	}
	
	override public function create():Void{
		var label:String;
		var back:FlxSprite;
		var hgtext:FlxText = new FlxText(FlxG.width / 3 - 65, 210,350);
		var timetext:FlxText = new FlxText(FlxG.width / 3 - 65, 240,350);
		var totalScore:FlxText = new FlxText(FlxG.width / 3 - 65, 270,250);
		
		if (arcade == 0 || TouchMyBall.currentLevel>10){
			label="Return to Menu";
			back = new FlxSprite(0,0,"gameresults");
			var end:FlxText = new FlxText(FlxG.width / 3 - 65, 300,350, "This is the end, but you can always try to make a new highscore!");
			add(end);
		}else{
			label = "Play level "+TouchMyBall.currentLevel;
			back = new FlxSprite(0,0,"nextlevel");
		}	
		
		back.scrollFactor.x = back.scrollFactor.y = 0;
		add(back);

		var startButton:FlxButton = new FlxButton(FlxG.width / 2 - 20, FlxG.height - 84, label, onClick);
		#if !neko
		//startButton.color = 0x666699;
		startButton.label.color = 0x9999ff;
		#else
		startButton.color = { rgb: 0x666699, a: 0xff };
		startButton.label.color = { rgb: 0x9999ff, a: 0xff };
		#end
		startButton.scale.x = startButton.scale.y = 2;
		startButton.antialiasing = true;
		add(startButton);
		#if !mobile
		FlxG._game.useSystemCursor = true;
		
		#end
		
		//trace("Arcade:"+arcade);
		
		var score:Int;
		hgtext.size = timetext.size = totalScore.size  = 12;
		
		if (timeSaved >0 && arcade > 1){
			timetext.text = "Bonus Time: "+timeSaved;
			score = FlxG.score + timeSaved;
			add(timetext);
		}else
			score = FlxG.score;
		totalScore.text = "Total current Score: "+ score;
		
		if(TouchMyBall.saveScore.bind("Mode"))
		{
			if (arcade > 1){
				if(TouchMyBall.saveScore.data.hg == null)
					TouchMyBall.saveScore.data.hg = score;
				else if (TouchMyBall.saveScore.data.hg < score){
					hgtext.text = "You made a new highscore! "+ (score - Std.parseInt(TouchMyBall.saveScore.data.hg))+ " points better!";
					TouchMyBall.saveScore.data.hg = score;
					add(hgtext);
				}
			
			}else if (arcade == 0){
				if (TouchMyBall.saveScore.data.hga == null)
					TouchMyBall.saveScore.data.hga = score;
				else if (TouchMyBall.saveScore.data.hga < score ){
					hgtext.text = "You made a new highscore! "+ (score - Std.parseInt(TouchMyBall.saveScore.data.hga))+ " points better!";
					TouchMyBall.saveScore.data.hga = score;
					add(hgtext);
				}
			
			}
			//trace("Number of highscores: "+TouchMyBall.saveScore.data.hg);
		}
		FlxG.score+=timeSaved;
		add(totalScore);
	}		
	
	public function onClick () : Void {
		if ((arcade==0)||TouchMyBall.currentLevel>10)
			FlxG.switchState(new MenuState());
		else
			FlxG.switchState(new TouchMyBall(TouchMyBall.currentLevel));
		
		//trace("CLICK");
	}

}
