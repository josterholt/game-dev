//Code generated with DAME. http://www.dambots.com

package 
{
	import org.flixel.*;
	public class Level_ extends BaseLevel
	{
		//Embedded media...
		[Embed(source="../map/mapCSV_Level1_terrain.csv", mimeType="application/octet-stream")] public var CSV_Level1terrain:Class;
		[Embed(source="../assets/platform0.png")] public var Img_Level1terrain:Class;
		[Embed(source="../map/mapCSV_Baddies_Map1.csv", mimeType="application/octet-stream")] public var CSV_BaddiesMap1:Class;
		[Embed(source="../assets/baddies.png")] public var Img_BaddiesMap1:Class;
		[Embed(source="../map/mapCSV_Laddders_1.csv", mimeType="application/octet-stream")] public var CSV_Laddders1:Class;
		[Embed(source="../assets/platform0.png")] public var Img_Laddders1:Class;
		[Embed(source="../map/mapCSV_BaddyCmds_1.csv", mimeType="application/octet-stream")] public var CSV_BaddyCmds1:Class;
		[Embed(source="../assets/platform0.png")] public var Img_BaddyCmds1:Class;

		//Tilemaps
		public var layerLevel1terrain:FlxTilemap;
		public var layerBaddiesMap1:FlxTilemap;
		public var layerLaddders1:FlxTilemap;
		public var layerBaddyCmds1:FlxTilemap;

		//Sprites


		public function Level_(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerLevel1terrain = new FlxTilemap;
			layerLevel1terrain.loadMap( new CSV_Level1terrain, Img_Level1terrain, 25,25, FlxTilemap.OFF, 0, 1, 1 );
			layerLevel1terrain.x = 0.000000;
			layerLevel1terrain.y = 0.000000;
			layerLevel1terrain.scrollFactor.x = 1.000000;
			layerLevel1terrain.scrollFactor.y = 1.000000;
			layerBaddiesMap1 = new FlxTilemap;
			layerBaddiesMap1.loadMap( new CSV_BaddiesMap1, Img_BaddiesMap1, 25,25, FlxTilemap.OFF, 0, 1, 1 );
			layerBaddiesMap1.x = 0.000000;
			layerBaddiesMap1.y = 0.000000;
			layerBaddiesMap1.scrollFactor.x = 1.000000;
			layerBaddiesMap1.scrollFactor.y = 1.000000;
			layerLaddders1 = new FlxTilemap;
			layerLaddders1.loadMap( new CSV_Laddders1, Img_Laddders1, 25,25, FlxTilemap.OFF, 0, 1, 1 );
			layerLaddders1.x = 0.000000;
			layerLaddders1.y = 0.000000;
			layerLaddders1.scrollFactor.x = 1.000000;
			layerLaddders1.scrollFactor.y = 1.000000;
			layerBaddyCmds1 = new FlxTilemap;
			layerBaddyCmds1.loadMap( new CSV_BaddyCmds1, Img_BaddyCmds1, 25,25, FlxTilemap.OFF, 0, 1, 1 );
			layerBaddyCmds1.x = 0.000000;
			layerBaddyCmds1.y = 0.000000;
			layerBaddyCmds1.scrollFactor.x = 1.000000;
			layerBaddyCmds1.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerLevel1terrain);
			masterLayer.add(layerBaddiesMap1);
			masterLayer.add(layerLaddders1);
			masterLayer.add(layerBaddyCmds1);


			if ( addToStage )
			{
				FlxG.state.add(masterLayer);
			}

			mainLayer = layer;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 625;
			boundsMaxY = 625;

		}


	}
}
