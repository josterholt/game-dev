package
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.greensock.TweenMax;
	import org.flixel.plugin.photonstorm.FX.GlitchFX;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	
	
	public class TitleScreen extends FlxState
	{
		public var titleScreen:FlxSprite;
		public var glitch:GlitchFX;
		[Embed(source = "/../assets/splashpage.png")]  public var rawTitleScreen:Class;
		
		override public function create():void
		{
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			titleScreen = new FlxSprite( -50, 0, rawTitleScreen );
			glitch = FlxSpecialFX.glitch();
			var scratch:FlxSprite = glitch.createFromFlxSprite(titleScreen, 2, 2);
			glitch.start(4);
			add(scratch);
			
			
			
			
			
			var controlText:FlxText = new FlxText(10, 10, 800);
			controlText.text = 'Movement: Arrow keys\nFire: Control';
			controlText.size = 14;
			add(controlText);
			
			var startText:FlxText = new FlxText(300, 500, 200);
			startText.text = 'Hit control to begin';
			startText.size = 16;
			add(startText);
			
			TweenMax.to(startText, 1, { alpha: 0.01, repeat: -1, yoyo: true } );
			
			
			

		}
		
		override public function update():void
		{
			super.update();
			
			if( FlxG.keys.CONTROL == true )
			{
				glitch.stop();
				FlxG.switchState( new PlayState() );
			}
		}	
	}
}