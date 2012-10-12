package;

import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;
import org.flixel.FlxG;
import org.flixel.FlxText;
import org.flixel.FlxSprite;

/**
 * ...
 * @author Sean Diamond
 */
class DynamicText extends FlxText
{
	private var _border:FlxSprite;
	private var _background:FlxSprite;
	
	public var textLeft:FlxText;
	public var textRight:FlxText;
		
	private var dieTimer:Timer;
	
	public function new(x:Int,y:Int,width:Int,text:String) 
	{
		_border = new FlxSprite(x-70,y);
		_border.makeGraphic(width, 70, 0xffffffff);
		FlxG.state.add(_border);
		
		_background = new FlxSprite(x-70,y);
		_background.makeGraphic(width-2, 70 - 2, 0xff000000);
		FlxG.state.add(_background);
		
		//add text to the current state
/*		this.scrollFactor.x = 0;
		this.scrollFactor.y = 0;*/
		FlxG.state.add(this);
		super(x, y, width, text);
	}
	
	
	
	public function fadeAndDie() {
		//fade the text
		dieTimer = new Timer(400, 2);
		
		dieTimer.addEventListener(TimerEvent.TIMER, fadeText);
		dieTimer.addEventListener(TimerEvent.TIMER_COMPLETE, dieText);
		dieTimer.start();
	}
	
	private function dieText(e:TimerEvent):Void 
	{
		dieTimer.removeEventListener(TimerEvent.TIMER, fadeText);
		dieTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, dieText);	
		FlxG.state.remove(this);
		FlxG.state.remove(_background);
		FlxG.state.remove(_border);
	}
	
	private function fadeText(e:Event):Void 
	{
		this.alpha = this.alpha -.3;
		_background.alpha -=.3;
		_border.alpha -=.3;
	}
	
	
}

