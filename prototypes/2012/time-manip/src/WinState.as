package  
{
	import org.flixel.*;

	public class WinState extends FlxState
	{
		
		override public function create():void
		{
			
			var timerTxt:FlxText = new FlxText((FlxG.stage.width / 2) - 100 , (FlxG.stage.height / 2) - 100, 300, "Level Complete");
			timerTxt.color = 0x00ff00;
			timerTxt.shadow = 0xff0000;
			timerTxt.scrollFactor.x = 0;
			timerTxt.scrollFactor.y = 0;
			timerTxt.size = 24;
			add(timerTxt);
			
			var cmdTxt:FlxText = new FlxText((FlxG.stage.width / 2) - 100 , (FlxG.stage.height / 2) - 50, 300, "Press Enter");
			cmdTxt.color = 0xffffff;
			cmdTxt.shadow = 0xff0000;
			cmdTxt.scrollFactor.x = 0;
			cmdTxt.scrollFactor.y = 0;
			cmdTxt.size = 24;
			add(cmdTxt);			
		}
		
		override public function update():void
		{
			super.update();

			if(FlxG.keys.ENTER == true) 
			{
				FlxG.switchState( new PlayState() );
			}

		}
		
	}

}