package
{
	import flash.display.Sprite;
	import org.flixel.FlxGame;
	import org.flixel.FlxG;
	
	[SWF(width = "1024", height = "600", backgroundColor = "#FFFFFF")]
	public class Main  extends FlxGame
	{
		public function Main() 
		{
			super(1024, 600, PlayState);
		}
		
	}

}