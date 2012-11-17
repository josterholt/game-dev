//Code generated with DAME. http://www.dambots.com

package 
{
	import org.flixel.*;
	import flash.utils.Dictionary;
	public class Level_Level1 extends BaseLevel
	{
		//Embedded media...
		[Embed(source="../map/mapCSV_Level1_terrain.csv", mimeType="application/octet-stream")] public var CSV_terrain:Class;
		[Embed(source="../assets/platform0.png")] public var Img_terrain:Class;

		//Tilemaps
		public var layerterrain:FlxTilemap;

		//Properties


		public function Level_Level1(addToStage:Boolean = true, onAddCallback:Function = null, parentObject:Object = null)
		{
			// Generate maps.
			var properties:Array = [];
			var tileProperties:Dictionary = new Dictionary;

			properties = generateProperties( null );
			layerterrain = addTilemap( CSV_terrain, Img_terrain, 0.000, 0.000, 25, 25, 1.000, 1.000, false, 1, 1, properties, onAddCallback );

			//Add layers to the master group in correct order.
			masterLayer.add(layerterrain);

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
