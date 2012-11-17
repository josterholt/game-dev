//Code generated with DAME. http://www.dambots.com

package 
{
	import org.flixel.*;
	import flash.utils.Dictionary;
	public class Level_Laddders extends BaseLevel
	{
		//Embedded media...
		[Embed(source="../map/mapCSV_Laddders_1.csv", mimeType="application/octet-stream")] public var CSV_1:Class;
		[Embed(source="../assets/platform0.png")] public var Img_1:Class;

		//Tilemaps
		public var layer1:FlxTilemap;

		//Properties


		public function Level_Laddders(addToStage:Boolean = true, onAddCallback:Function = null, parentObject:Object = null)
		{
			// Generate maps.
			var properties:Array = [];
			var tileProperties:Dictionary = new Dictionary;

			properties = generateProperties( null );
			layer1 = addTilemap( CSV_1, Img_1, 0.000, 0.000, 25, 25, 1.000, 1.000, false, 1, 1, properties, onAddCallback );

			//Add layers to the master group in correct order.
			masterLayer.add(layer1);

			if ( addToStage )
				createObjects(onAddCallback, parentObject);

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 625;
			boundsMaxY = 625;
			boundsMin = new FlxPoint(0, 0);
			boundsMax = new FlxPoint(625, 625);
			bgColor = 0xff000000;
		}

		override public function createObjects(onAddCallback:Function = null, parentObject:Object = null):void
		{
			generateObjectLinks(onAddCallback);
			if ( parentObject != null )
				parentObject.add(masterLayer);
			else
				FlxG.state.add(masterLayer);
		}

		public function generateObjectLinks(onAddCallback:Function = null):void
		{
		}

	}
}
