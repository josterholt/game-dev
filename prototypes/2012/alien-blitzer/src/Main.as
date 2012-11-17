package 
{
	import org.flixel.*;
	public class Main extends FlxGame
	{
		[Embed(source = "/../assets/track1b.mp3")] public var track1:Class;	
		[Frame(factoryClass = "Preloader")]
		public function Main():void 
		{
			//FlxG.playMusic(track1, 1);
			super(800, 600, TitleScreen, 1);
		}
		
	}
	
}