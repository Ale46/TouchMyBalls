package;

/**
 * ...
 * @author Ale46
 */

import nme.display.Sprite;
import nme.Lib;


class Main extends Sprite
{
	public static function main() 
	{
		new Main();
	}
	
	
	public function new() 
	{
		super();
		Lib.current.addChild(new GameStart());
        

	}
	
}