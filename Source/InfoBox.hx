package ;

import org.flixel.FlxSprite;
import org.flixel.FlxText;
import org.flixel.FlxGroup;
/**
 * ...
 * @author Ale46
 */
	class Infobox extends FlxGroup 
	{
		private var _border:FlxSprite;
		private var _background:FlxSprite;
		
		public var textLeft:FlxText;
		public var textRight:FlxText;
		
		public function Infobox() 
		{
			_border = new FlxSprite();
			_border.makeGraphic(126, 90, 0xffffffff);
			add(_border);
			
			_background = new FlxSprite();
			_background.makeGraphic(_border.width - 2, _border.height - 2, 0xff000000);
			add(_background);
			
			textLeft = new FlxText(0, 0, _background.width);
			textLeft.setFormat(null, 10);
			add(textLeft);
			
			textRight = new FlxText(0, 0, _background.width);
			textRight.setFormat(null, 10, 0xffffff, "right");
			add(textRight);
		}
		
		override public function update():Void 
		{
			super.update();
			
			x = FlxG.mouse.screenX + 11;
			y = FlxG.mouse.screenY + 28;
		}
		
		public function set_x(X:Int):Void
		{
			_border.x = X;
			_background.x = X + 1;
			textLeft.x = X;
			textRight.x = X;
		}
		
		public function set_y(Y:Int):Void
		{
			_border.y = Y;
			_background.y = Y + 1;
			textLeft.y = Y;
			textRight.y = Y;
		}
		
	}
