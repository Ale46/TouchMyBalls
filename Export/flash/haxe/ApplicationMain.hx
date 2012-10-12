import Main;
import nme.Assets;
import nme.events.Event;


class ApplicationMain {
	
	static var mPreloader:NMEPreloader;

	public static function main () {
		
		var call_real = true;
		
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		
		nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		
		if (loaded < total || true) /* Always wait for event */ {
			
			call_real = false;
			mPreloader = new Preloader();
			nme.Lib.current.addChild(mPreloader);
			mPreloader.onInit();
			mPreloader.onUpdate(loaded,total);
			nme.Lib.current.addEventListener (nme.events.Event.ENTER_FRAME, onEnter);
			
		}
		
		
		
		haxe.Log.trace = flashTrace; // null
		

		if (call_real)
			begin ();
	}

	
	private static function flashTrace( v : Dynamic, ?pos : haxe.PosInfos ) {
		var className = pos.className.substr(pos.className.lastIndexOf('.') + 1);
		var message = className+"::"+pos.methodName+":"+pos.lineNumber+": " + v;

        if (flash.external.ExternalInterface.available)
			flash.external.ExternalInterface.call("console.log", message);
		else untyped flash.Boot.__trace(v, pos);
    }
	
	
	private static function begin () {
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields(Main))
		{
			if (methodName == "main")
			{
				hasMain = true;
				break;
			}
		}
		
		if (hasMain)
		{
			Reflect.callMethod (Main, Reflect.field (Main, "main"), []);
		}
		else
		{
			nme.Lib.current.addChild(cast (Type.createInstance(Main, []), nme.display.DisplayObject));	
		}
		
	}

	static function onEnter (_) {
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		mPreloader.onUpdate(loaded,total);
		
		if (loaded >= total) {
			
			nme.Lib.current.removeEventListener(nme.events.Event.ENTER_FRAME, onEnter);
			mPreloader.addEventListener (Event.COMPLETE, preloader_onComplete);
			mPreloader.onLoaded();
			
		}
		
	}

	public static function getAsset (inName:String):Dynamic {
		
		
		if (inName=="assets/data/courier.ttf")
			 
			 return Assets.getFont ("assets/data/courier.ttf");
		 
		
		if (inName=="assets/data/nokiafc22.ttf")
			 
			 return Assets.getFont ("assets/data/nokiafc22.ttf");
		 
		
		if (inName=="assets/data/button.png")
			 
            return Assets.getBitmapData ("assets/data/button.png");
         
		
		if (inName=="assets/data/cursor.png")
			 
            return Assets.getBitmapData ("assets/data/cursor.png");
         
		
		if (inName=="assets/data/default.png")
			 
            return Assets.getBitmapData ("assets/data/default.png");
         
		
		if (inName=="assets/data/fontData10pt.png")
			 
            return Assets.getBitmapData ("assets/data/fontData10pt.png");
         
		
		if (inName=="assets/data/fontData11pt.png")
			 
            return Assets.getBitmapData ("assets/data/fontData11pt.png");
         
		
		if (inName=="assets/data/handle.png")
			 
            return Assets.getBitmapData ("assets/data/handle.png");
         
		
		if (inName=="assets/data/logo_corners.png")
			 
            return Assets.getBitmapData ("assets/data/logo_corners.png");
         
		
		if (inName=="assets/data/logo_light.png")
			 
            return Assets.getBitmapData ("assets/data/logo_light.png");
         
		
		if (inName=="assets/data/vcr/flixel.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/flixel.png");
         
		
		if (inName=="assets/data/vcr/open.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/open.png");
         
		
		if (inName=="assets/data/vcr/pause.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/pause.png");
         
		
		if (inName=="assets/data/vcr/play.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/play.png");
         
		
		if (inName=="assets/data/vcr/record_off.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/record_off.png");
         
		
		if (inName=="assets/data/vcr/record_on.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/record_on.png");
         
		
		if (inName=="assets/data/vcr/restart.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/restart.png");
         
		
		if (inName=="assets/data/vcr/step.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/step.png");
         
		
		if (inName=="assets/data/vcr/stop.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/stop.png");
         
		
		if (inName=="assets/data/vis/bounds.png")
			 
            return Assets.getBitmapData ("assets/data/vis/bounds.png");
         
		
		if (inName=="assets/data/vcr/flixel.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/flixel.png");
         
		
		if (inName=="assets/data/vcr/open.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/open.png");
         
		
		if (inName=="assets/data/vcr/pause.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/pause.png");
         
		
		if (inName=="assets/data/vcr/play.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/play.png");
         
		
		if (inName=="assets/data/vcr/record_off.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/record_off.png");
         
		
		if (inName=="assets/data/vcr/record_on.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/record_on.png");
         
		
		if (inName=="assets/data/vcr/restart.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/restart.png");
         
		
		if (inName=="assets/data/vcr/step.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/step.png");
         
		
		if (inName=="assets/data/vcr/stop.png")
			 
            return Assets.getBitmapData ("assets/data/vcr/stop.png");
         
		
		if (inName=="assets/data/vis/bounds.png")
			 
            return Assets.getBitmapData ("assets/data/vis/bounds.png");
         
		
		if (inName=="level1")
			 
            return Assets.getSound ("level1");
		 
		
		if (inName=="level2")
			 
            return Assets.getSound ("level2");
		 
		
		if (inName=="level3")
			 
            return Assets.getSound ("level3");
		 
		
		if (inName=="level4")
			 
            return Assets.getSound ("level4");
		 
		
		if (inName=="level5")
			 
            return Assets.getSound ("level5");
		 
		
		if (inName=="level6")
			 
            return Assets.getSound ("level6");
		 
		
		if (inName=="level7")
			 
            return Assets.getSound ("level7");
		 
		
		if (inName=="level8")
			 
            return Assets.getSound ("level8");
		 
		
		if (inName=="level9")
			 
            return Assets.getSound ("level9");
		 
		
		if (inName=="level10")
			 
            return Assets.getSound ("level10");
		 
		
		if (inName=="arcade")
			 
            return Assets.getSound ("arcade");
		 
		
		if (inName=="menu")
			 
            return Assets.getSound ("menu");
		 
		
		if (inName=="explode")
			 
            return Assets.getSound ("explode");
         
		
		if (inName=="logo")
			 
            return Assets.getBitmapData ("logo");
         
		
		if (inName=="soundon")
			 
            return Assets.getBitmapData ("soundon");
         
		
		if (inName=="soundoff")
			 
            return Assets.getBitmapData ("soundoff");
         
		
		if (inName=="gameover")
			 
            return Assets.getBitmapData ("gameover");
         
		
		if (inName=="nextlevel")
			 
            return Assets.getBitmapData ("nextlevel");
         
		
		if (inName=="gameresults")
			 
            return Assets.getBitmapData ("gameresults");
         
		
		if (inName=="statics")
			 
            return Assets.getBitmapData ("statics");
         
		
		if (inName=="rainbow")
			 
            return Assets.getBitmapData ("rainbow");
         
		
		if (inName=="gamebackground")
			 
            return Assets.getBitmapData ("gamebackground");
         
		
		if (inName=="colorchanged")
			 
            return Assets.getBitmapData ("colorchanged");
         
		
		if (inName=="background")
			 
            return Assets.getBitmapData ("background");
         
		
		if (inName=="touch")
			 
            return Assets.getBitmapData ("touch");
         
		
		if (inName=="my")
			 
            return Assets.getBitmapData ("my");
         
		
		if (inName=="balls")
			 
            return Assets.getBitmapData ("balls");
         
		
		
		return null;
		
	}
	
	
	private static function preloader_onComplete (event:Event):Void {
		
		mPreloader.removeEventListener (Event.COMPLETE, preloader_onComplete);
		
		nme.Lib.current.removeChild(mPreloader);
		mPreloader = null;
		
		begin ();
		
	}
	
}


class NME_assets_data_courier_ttf extends nme.text.Font { }
class NME_assets_data_nokiafc22_ttf extends nme.text.Font { }
class NME_assets_data_button_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_cursor_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_default_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_fontdata10pt_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_fontdata11pt_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_handle_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_logo_corners_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_logo_light_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_flixel_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_open_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_pause_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_play_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_record_off_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_record_on_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_restart_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_step_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_stop_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vis_bounds_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_flixel_png1 extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_open_png1 extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_pause_png1 extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_play_png1 extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_record_off_png1 extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_record_on_png1 extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_restart_png1 extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_step_png1 extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vcr_stop_png1 extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_data_vis_bounds_png1 extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_level1_mp3 extends nme.media.Sound { }
class NME_assets_level2_mp3 extends nme.media.Sound { }
class NME_assets_level3_mp3 extends nme.media.Sound { }
class NME_assets_level4_mp3 extends nme.media.Sound { }
class NME_assets_level5_mp3 extends nme.media.Sound { }
class NME_assets_level6_mp3 extends nme.media.Sound { }
class NME_assets_level7_mp3 extends nme.media.Sound { }
class NME_assets_level8_wav extends nme.media.Sound { }
class NME_assets_level9_wav extends nme.media.Sound { }
class NME_assets_level10_wav extends nme.media.Sound { }
class NME_assets_arcade_mp3 extends nme.media.Sound { }
class NME_assets_menu_mp3 extends nme.media.Sound { }
class NME_assets_explode_mp3 extends nme.media.Sound { }
class NME_assets_logo_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_soundon_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_soundoff_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_gameover_640x480_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_nextlevel_640x480_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_gameresults_640x480_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_statics_640x480_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_rainbow_medium_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_game_background_640x480_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_color_changed_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_back_back_640x480_land_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_back_back_640x480_touch_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_back_back_640x480_my_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_back_back_640x480_balls_png extends nme.display.BitmapData { public function new () { super (0, 0); } }

