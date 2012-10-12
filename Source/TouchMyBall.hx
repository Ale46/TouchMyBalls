package;

import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import org.flixel.FlxText;
import org.flixel.FlxSprite;
import nme.Assets;
import org.flixel.FlxState;
import org.flixel.FlxG;
import flash.display.Sprite;
import nme.display.BitmapData;
import org.flixel.FlxEmitter;
import org.flixel.FlxParticle;
import nme.filters.GlowFilter;
import org.flixel.FlxSave;
import nme.display.Bitmap;
/**
 * ...
 * @author Ale46
 */

 
 typedef Color = {
	var value:Int;
	var name : String;
	
}

typedef Mole = {
	var color : Color;
	var name : Int;
	var obj : Sprite;
}

typedef Level = {
	var levelNum : Int;
	var levelTime : Float;
	var objTime : Float;
	var objNum : Int;
}



class TouchMyBall extends FlxState
{


	var goalColor:Color;
	var startTime:Int;
	var randomChange:Float;
	var currentGoalColorText:FlxText;
	var scoreText:FlxText;
	var totalscoreText:FlxText;
	var score:Int;
	var timeText:FlxText;
	var currentLevelText:FlxText;
	var levelGoalText:FlxText;
	var levelGoaTimelText:FlxText;
	var currentGoalColor:FlxText;
	var all : Color;
	public static var saveScore:FlxSave;
	var colorArray:Array<Color>;
	var gx:GlowFilter;
	public static var currentLevel:Int;
	var rainbow:FlxSprite;
	var rainbow2:FlxSprite;
	var moles:Array<Mole>;
	var loadedlevel:Level;
	var levelIsRunning:Bool;
	var molesOnStage:Int;
	var emitter:FlxEmitter;
	var changed:FlxSprite;	
	var currentGoalColorLabel:FlxText;
	var soundOn:Bitmap;
	var soundOff:Bitmap;
	var soundSprite:Sprite;
	
		public function new(level:Int = 1) 
	{
		currentLevel = level;
		//this.score = score;
		#if mobile
		FlxG.mobile = true;
		#end
		FlxG.debug = true;
		//FlxG.visualDebug = true;
		
		super();
		
	}
	
	override public function create():Void
	{
		
		initialize ();
		construct ();
	}
	

	
		private function animateCircle (circle:Sprite):Void {
		
		if (levelIsRunning){
			var duration:Float = 1.5 + Math.random () * 4.5;
			var targetX:Float = (Math.random () * FlxG.stage.stageWidth);//FlxG._game.stage.width) ;//- circle.width*2;
			var targetY:Float = (Math.random () * FlxG.stage.stageHeight); //FlxG._game.stage.height) ;//- circle.height*2;
						
			Actuate.tween (circle, duration, { x: targetX, y: targetY }, false).ease (Quad.easeIn).onComplete (animateCircle, [ circle ]);
		}
	}
	
	
	private function construct ():Void {
		
		var creationDelay:Float;
		
		for (i in 0...loadedlevel.objNum+Std.int(loadedlevel.objNum/(currentLevel+1))) {
			molesOnStage++;
			creationDelay = Math.random () * 10;
			Actuate.timer (creationDelay).onComplete (createCircle);
			
		}
		
	}
	
	
	private function createCircle ():Void {
		if (levelIsRunning){
			var size:Float = 5 + Math.random () * 35 + 20;
			
			var circleColor:Color = colorArray[Std.random(colorArray.length)];
			
			var circle1:Sprite = new Sprite ();
			circle1.alpha = 0.2 + Math.random () * 0.6;
			circle1.name = Std.string(moles.length);
			
			circle1.graphics.beginFill(circleColor.value);
			circle1.graphics.drawCircle (0, 0, size);
			circle1.alpha = 0.2 + Math.random () * 0.6;
			circle1.x = Math.random () * FlxG._game.stage.width - circle1.width*2;
			
			circle1.y = Math.random () * FlxG._game.stage.height - circle1.height*2;
			circle1.name = Std.string(moles.length);
			circle1.addEventListener (MouseEvent.MOUSE_DOWN, _onClick);
			#if (cpp||mobile)
			gx = new GlowFilter(circleColor.value,1,12,12,2,nme.filters.BitmapFilterQuality.LOW);
			#else
			gx = new GlowFilter(circleColor.value,1,50,50);
			#end
			//gx.quality = nme.filters.BitmapFilterQuality.MEDIUM;
			circle1.filters = [gx];			
			
			animateCircle (circle1);
			var mole:Mole = { color : circleColor , name : moles.length , obj: circle1};
			moles.push(mole);
			
			FlxG.stage.addChild(circle1);
		
		}
		
	}
	
	
	
	private function _onClick (event:MouseEvent):Void {
 		if (this.levelIsRunning){
			var mole:Sprite = cast (event.currentTarget, Sprite);
			var i:Int = Std.parseInt(mole.name);
		 	emitter = new FlxEmitter(FlxG.mouse.getScreenPosition().x,FlxG.mouse.getScreenPosition().y, 15);
			var particle:FlxParticle;
			var c:String = moles[i].color.name;
			var color:Int;
			molesOnStage--;
			switch(c){
				case "Red":
					color = 0xFF0000;
				case "Blue":
					color = 0x0000FF;
				case "Green":
					color = 0x00FF00;
				default:
					color = 0x000000;	
			}
			
			for(i in 0...15)
			{
				particle = new FlxParticle();
				
				
				particle.makeGraphic(2, 2, 0xFF000000 + color);	
				particle.alpha = 1;
		  		particle.updateTileSheet();
				
				emitter.add(particle);
			}

			add(emitter);
			
			emitter.start(true,3);
			
			if (c != goalColor.name && goalColor.name != "All"){
			//	trace("Wrong color");
				FlxG.score--;
				score--;
			}else {
			//	trace("OK");
				FlxG.score++; 
				score++;
			}
			
			
			scoreText.text = "Score: "+ Std.string(score);
			totalscoreText.text = "Total Score: "+ Std.string(FlxG.score);
			//trace(moles[i].name + " - " + moles[i].color.name+"->");// + " " + ;
			
			FlxG.play(Assets.getSound("explode"));
			
			FlxG.stage.removeChild (mole);
			
			mole.removeEventListener (MouseEvent.CLICK, _onClick);
			//moles[i] = null;
		}
		
		 
	}
	
	private function initialize ():Void {

		FlxG._game.stage.align = StageAlign.TOP_LEFT;
		
		FlxG._game.stage.scaleMode= StageScaleMode.NO_SCALE;
		FlxG._game.addEventListener (Event.ACTIVATE, stage_onActivate);
		FlxG._game.addEventListener (Event.DEACTIVATE, stage_onDeactivate);
		
		currentLevelText = new FlxText(200, 0, 100, "Level: "+currentLevel);
		scoreText = new FlxText(120, 0, 100, "Score: 0");
		totalscoreText = new FlxText(350, 0, 130, "Total Score: "+FlxG.score);
		timeText = new FlxText(2, 0, 110, "Time: 0");
		timeText.size = currentLevelText.size = scoreText.size = totalscoreText.size = 12;
		timeText.antialiasing = currentLevelText.antialiasing = scoreText.antialiasing = totalscoreText.antialiasing = true;
		molesOnStage =0;
		score = 0;
		var startcircleNum:Int = 5;
		var timeStart:Float = 55;
		var objTimeStart:Float = 15;
		if (currentLevel>0)
			loadedlevel = { objNum : startcircleNum + 2*currentLevel , levelNum : currentLevel, levelTime: timeStart - (currentLevel * 3) , objTime: objTimeStart - currentLevel }
		else
			loadedlevel = { objNum : 0 , levelNum : 0, levelTime: 180 , objTime: 10 }
		
		levelGoalText = new FlxText(280, 0, 100, "Goal: "+loadedlevel.objNum);
		levelGoalText.size = 12;
		levelGoaTimelText = new FlxText(2, 14, 140, "MaxTime: "+loadedlevel.levelTime);
		levelGoaTimelText.size = 12;
		
		levelIsRunning = true;
		
		
		moles = new Array();
		soundSprite = new Sprite();
		soundOn = new Bitmap(Assets.getBitmapData("soundon"));
		soundOff = new Bitmap(Assets.getBitmapData("soundoff"));
		soundSprite.addChild(soundOn);
		soundSprite.addEventListener(MouseEvent.MOUSE_DOWN, sound_click);
		//sound = (Assets.getBitmapData("soundon"));
		soundSprite.x = 610;
		soundSprite.y = 450;
		//soundSprite.scaleX = soundSprite.scaleY = 0.7;
		
		FlxG.stage.addChild(soundSprite);
		
		var red : Color = { value : 0xFF0000, name : "Red" };
		var blue : Color = { value : 0x0000FF, name : "Blue" };
		var green : Color = { value : 0x00FF00, name : "Green" };
		all = { value : 0x000000, name : "All" };
		colorArray = [ blue, green, red ];
		
		//emitter = new FlxEmitter(0,0,15);
		
		startTime = Lib.getTimer ();
		//FlxG._game.addEventListener(Event.ENTER_FRAME,startTimer);
		
		rainbow = new FlxSprite();
		rainbow2 = new FlxSprite();
		var background:FlxSprite = new FlxSprite();
		background.loadGraphic("gamebackground");
		background.scrollFactor.x = background.scrollFactor.y = 0;
		
		add(background);
		rainbow.loadGraphic("rainbow");
		rainbow.scale.x = rainbow.scale.y = 0.6;
		rainbow.antialiasing = true;
		rainbow.x = 350;
		
		rainbow2.loadFrom(rainbow);
		rainbow2.scale.x = rainbow2.scale.y = 0.6;
		rainbow2.antialiasing = true;
		rainbow2.x = 0;
		
		saveScore = new FlxSave();
		
		changed = new FlxSprite();
		changed.loadGraphic("colorchanged");
		//changed.scale.x = changed.scale.y = 2;
		changed.antialiasing = true;
		changed.visible = false;
		changed.x = (FlxG.stage.stageWidth / 2)-changed.width/2;
		changed.y = (FlxG.stage.stageHeight /2 )- changed.height/2;
		if(saveScore.bind("Mode"))
		{
			if(saveScore.data.plays == null||saveScore.data.time==null||saveScore.data.balls == null){
				saveScore.data.plays = 0;
				saveScore.data.time = 0;
				saveScore.data.balls = 0;
				
			}
			saveScore.data.plays++;
			//trace("Number of plays: "+saveScore.data.plays);
		}
		

			
		goalColor = colorArray[Std.random(colorArray.length)];//all;// colorArray[Std.random(colorArray.length)];
		
		
		currentGoalColorLabel = new FlxText(480, 0, 150, "Target Color: ");
		currentGoalColorLabel.size = 12;
		
		currentGoalColorText = new FlxText(545,0,120, goalColor.name);
		currentGoalColorText.setFormat(null, 12, goalColor.value, "center");
		
		if (currentLevel==0)
			randomChange = Std.random(10) + 10;
		else
			randomChange = Std.random(10) + 3;
		add(currentGoalColorText);
		add(currentGoalColorLabel);
		add(scoreText);
		add(timeText);
		add(changed);
		add(levelGoaTimelText);
		
		add(rainbow);
		add(rainbow2);
		if (currentLevel>0){
			add(totalscoreText);
			add(currentLevelText);
			
			add(levelGoalText);
			FlxG.playMusic(Assets.getSound("level"+Std.string(currentLevel)),1);
		}else{
			FlxG.playMusic(Assets.getSound("arcade"),1);
		}
	}
	
	private function sound_click(event:MouseEvent):Void{
		if(FlxG.mute){
			soundSprite.removeChild(soundOff);
			soundSprite.addChild(soundOn);
		}else{
			soundSprite.addChild(soundOff);
			soundSprite.removeChild(soundOn);
		}
		FlxG.mute = !FlxG.mute;
	
	}
	
	
	//private function startTimer(event:Event):Void {
	public override function update(){
	
		//levelIsRunning = true;
		if (levelIsRunning){
			rainbow.y = Math.cos(Lib.getTimer () * 0.002) * 5;
			rainbow2.y = Math.sin(Lib.getTimer () * 0.002) * 5 +120;
			
			var elapsedTime:Float =  (Lib.getTimer () - startTime) / 1000;
			timeText.text = "Time: " + Std.string(elapsedTime);
			if (currentLevel >0 && (molesOnStage+score<loadedlevel.objNum)){
				
				
/*				if (FlxG.mute) soundSprite.removeChild(soundOff);
				else soundSprite.removeChild(soundOn);
				FlxG.stage.removeChild(soundSprite);
				
				levelIsRunning = false;
				//FlxG._game.removeEventListener(Event.ENTER_FRAME, startTimer);
				FlxG.destroySounds(true);
				
				for (i in 0...moles.length){
					if (moles[i].obj.hasEventListener != null) moles[i].obj.removeEventListener(MouseEvent.CLICK, _onClick);
					if (FlxG.stage.contains(moles[i].obj)) FlxG.stage.removeChild(moles[i].obj);
				}*/
				
				FlxG.switchState(new GameOver());
				
			}
			if (currentLevel == 0 && molesOnStage<7){
				
				var creationDelay:Float;
			
				for (i in 0...(Std.random(10)+5)) {
					molesOnStage++;
					
					creationDelay = Math.random () * 10;
					Actuate.timer (creationDelay).onComplete (createCircle);
					
				}
				
			}
			
			if (randomChange <  elapsedTime){
				
				if (goalColor.name != "All"){
					goalColor = all;
					currentGoalColorText.color = goalColor.value;
					currentGoalColorText.text = "All";
					randomChange = elapsedTime + Std.random(3)+2;
					
				}else{
					goalColor = colorArray[Std.random(colorArray.length)];
					currentGoalColorText.color = colorArray[Std.random(colorArray.length)].value;
					currentGoalColorText.text = goalColor.name;
					
					
					randomChange = elapsedTime + Std.random(7) + 5;
				}
				
				changed.visible = true;
				
				
				
				Actuate.tween (changed, 1, { x: changed.x+10, y: changed.y }, false).ease (Quad.easeIn).onComplete (hideChanged, [ false ]);
			}
			
				
			if (elapsedTime <= loadedlevel.levelTime && score == loadedlevel.objNum && currentLevel>0){
				saveScore.data.time += elapsedTime;
				saveScore.data.balls += score;
				currentLevel+=1;
				levelIsRunning = false;
				var timeSaved:Int = Std.int(loadedlevel.levelTime - elapsedTime);
/*				levelIsRunning = false;*
				soundSprite.removeEventListener(MouseEvent.CLICK, sound_click);
				FlxG.stage.removeChild(soundSprite);
/*				if (FlxG.mute) soundSprite.removeChild(soundOff);
				else soundSprite.removeChild(soundOn);*/
				//soundSprite = null;
				//FlxG._game.removeEventListener(Event.ENTER_FRAME, startTimer);
/*				emitter.kill();
				FlxG.destroySounds(true);
				for (i in 0...moles.length){
					if (moles[i].obj.hasEventListener != null) moles[i].obj.removeEventListener(MouseEvent.CLICK, _onClick);
					if (FlxG.stage.contains(moles[i].obj)) FlxG.stage.removeChild(moles[i].obj);
				}
				moles = new Array();*/
				FlxG.switchState(new NextLevel(currentLevel,timeSaved));
				
					
			}else if ((elapsedTime > loadedlevel.levelTime )){

				if (currentLevel>0 && currentLevel<11){
					FlxG.switchState(new GameOver());
	/*			}else if (currentLevel == 10){
					FlxG.switchState(new NextLevel(0));*/
				}else{
					FlxG.switchState(new NextLevel(0));
				}
			}
		}
		super.update();
			
	}
	
	private function hideChanged (value:Bool):Void{
		changed.visible = value;
		changed.x = (FlxG.stage.stageWidth / 2)-changed.width/2;
		changed.y = (FlxG.stage.stageHeight /2 )- changed.height/2;
	}

	private function stage_onActivate (event:Event):Void {
		levelIsRunning = true;
		Actuate.resumeAll ();
		FlxG.resumeSounds();
		
	}
	
	override function destroy():Void{
		
		soundSprite.removeEventListener(MouseEvent.CLICK, sound_click);
		if (FlxG.mute) soundSprite.removeChild(soundOff);
		else soundSprite.removeChild(soundOn);
		FlxG.stage.removeChild(soundSprite);
		
		emitter.kill();
		levelIsRunning = false;
		//FlxG._game.removeEventListener(Event.ENTER_FRAME, startTimer);
		FlxG.destroySounds(true);
		
		for (i in 0...moles.length){
			if (moles[i].obj.hasEventListener != null) moles[i].obj.removeEventListener(MouseEvent.CLICK, _onClick);
			if (FlxG.stage.contains(moles[i].obj)) FlxG.stage.removeChild(moles[i].obj);
		}
		moles = new Array();
		super.destroy();
	}
	private function stage_onDeactivate (event:Event):Void {
		levelIsRunning = false;
		Actuate.pauseAll ();
		FlxG.pauseSounds();
		
	}
	
	
}