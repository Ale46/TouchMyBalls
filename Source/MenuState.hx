package;

import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxSprite;
import nme.Assets;
import flash.Lib;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;
/**
 * ...
 * @author Ale46
 */

class MenuState extends FlxState
{

	var ballGame:TouchMyBall;
	var background:FlxSprite;
	var touch:FlxSprite;
	var my:FlxSprite;
	var balls:FlxSprite;
	
	public function new() 
	{
		super();
	}
	
	override public function create():Void {
		
		background = new FlxSprite();
		background.loadGraphic(("background"));
		background.scrollFactor.x = background.scrollFactor.y = 0;
		add(background);
		
		
		touch = new FlxSprite(40,66);
		touch.loadGraphic(("touch"));
		
		add(touch);
		animateCloud(touch);
		
		my = new FlxSprite(3,192);
		my.loadGraphic(("my"));
		
		add(my);
		animateCloud(my);
		
		balls = new FlxSprite(205,180);
		balls.loadGraphic(("balls"));
		
		add(balls);
		animateCloud(balls);
		
		var startLevelButton:FlxButton = new FlxButton(FlxG.width / 2 - 32, FlxG.height / 3 + 104, "Level Mode", onPlay_level);
		#if !neko
		startLevelButton.scale.x = startLevelButton.scale.y = 2;
		//startButton.color = 0x666699;
		//startButton.label.color = 0x9999ff;
		#else
		startLevelButton.color = { rgb: 0x666699, a: 0xff };
		startLevelButton.label.color = { rgb: 0x9999ff, a: 0xff };
		#end
		add(startLevelButton);
		
		var startArcadeButton:FlxButton = new FlxButton(FlxG.width / 2 - 32, FlxG.height / 3 + 154, "Arcade Mode", onPlay_arcade);
		#if !neko
		startArcadeButton.scale.x = startArcadeButton.scale.y = 2;
		//startButton.color = 0x666699;
		//startButton.label.color = 0x9999ff;
		#else
		startArcadeButton.color = { rgb: 0x666699, a: 0xff };
		startArcadeButton.label.color = { rgb: 0x9999ff, a: 0xff };
		#end
		add(startArcadeButton);
		
		
		var staticsButton:FlxButton = new FlxButton(FlxG.width / 2 - 32, FlxG.height / 3 + 204, "Statics", showStatics);
		#if !neko
		staticsButton.scale.x = staticsButton.scale.y = 2;
		//startButton.color = 0x666699;
		//startButton.label.color = 0x9999ff;
		#else
		staticsButton.color = { rgb: 0x666699, a: 0xff };
		staticsButton.label.color = { rgb: 0x9999ff, a: 0xff };
		#end
		add(staticsButton);
		
		
		
		#if !mobile
		FlxG._game.useSystemCursor = true;
		//FlxG.mouse.show("assets/cursor.png", 2);
		#end
		FlxG.playMusic(Assets.getSound("menu"),1);
		
	}
		
		
	private function animateCloud (circle:FlxSprite, negative:Bool = false):Void {
		
		
		
		var duration:Float = 1.5 + Math.random () * 4.5;
		var targetX:Float = (Math.random () * 90);//FlxG._game.stage.width) ;//- circle.width*2;
		var targetY:Float = (Math.random () * 15); //FlxG._game.stage.height) ;//- circle.height*2;
		if (negative) {
			targetX = circle.x - targetX; 
			targetY = circle.y - targetY;
		}else{
			targetX = circle.x + targetX; 
			targetY = circle.y + targetY;
		}
/*		if (targetX > FlxG.stage.stageWidth /* || targetY > FlxG.stage.stageHeight){
			targetX -=200;
			targetY-=200;
		}*/
		Actuate.tween (circle, duration, { x: targetX, y: targetY }, false).ease (Quad.easeIn).onComplete (animateCloud, [ circle , !negative]);
	
	}
	
		private function onPlay_level():Void
		{
			FlxG.destroySounds(true);
			FlxG.fade(0xff000000, 1, on_fade_level_completed);
		//FlxG.switchState(ballGame);
		
		}
		
		private function onPlay_arcade():Void
		{
			FlxG.destroySounds(true);
			FlxG.fade(0xff000000, 1, on_fade_arcade_completed);
		//FlxG.switchState(ballGame);
		
		}
	
		public function on_fade_level_completed():Void
		{
			FlxG.destroySounds(true);
			FlxG.switchState(new TouchMyBall());
		}
		
		public function on_fade_arcade_completed():Void
		{
			// playing the game itself
			FlxG.switchState(new TouchMyBall(0));
		}
		
		private function showStatics():Void
		{
			//FlxG.destroySounds(true);
			FlxG.switchState(new Statics());
			
			
		//FlxG.fade(0xff000000, 1, on_fade_completed);
			
		
		}
}