//Code generated with DAME. http://www.dambots.com

package 
{
	import org.flixel.*;
	import flash.utils.Dictionary;
	public class Level_Level1 extends BaseLevel
	{
		//Embedded media...
		[Embed(source="../../map/mapCSV_Level1_terrain.csv", mimeType="application/octet-stream")] public var CSV_terrain:Class;
		[Embed(source="../../assets/platform0.png")] public var Img_terrain:Class;
		[Embed(source="../../map/mapCSV_Level1_collectables.csv", mimeType="application/octet-stream")] public var CSV_collectables:Class;
		[Embed(source="../../assets/collectables.png")] public var Img_collectables:Class;
		[Embed(source="../../map/mapCSV_Level1_ladders.csv", mimeType="application/octet-stream")] public var CSV_ladders:Class;
		[Embed(source="../../assets/platform0.png")] public var Img_ladders:Class;

		//Tilemaps
		public var layerterrain:FlxTilemap;
		public var layercollectables:FlxTilemap;
		public var layerladders:FlxTilemap;

		//Sprites
		public var star-spriteGroup:FlxGroup = new FlxGroup;

		//Paths
		public var Layer5Group:FlxGroup = new FlxGroup;

		//Properties


		public function Level_Level1(addToStage:Boolean = true, onAddCallback:Function = null, parentObject:Object = null)
		{
			// Generate maps.
			var properties:Array = [];
			var tileProperties:Dictionary = new Dictionary;

			properties = generateProperties( null );
			layerterrain = addTilemap( CSV_terrain, Img_terrain, 0.000, 0.000, 25, 25, 1.000, 1.000, false, 1, 1, properties, onAddCallback );
			properties = generateProperties( null );
			layercollectables = addTilemap( CSV_collectables, Img_collectables, 0.000, 0.000, 15, 15, 1.000, 1.000, false, 1, 1, properties, onAddCallback );
			properties = generateProperties( null );
			layerladders = addTilemap( CSV_ladders, Img_ladders, 0.000, 0.000, 25, 25, 1.000, 1.000, false, 1, 1, properties, onAddCallback );

			//Add layers to the master group in correct order.
			masterLayer.add(layerterrain);
			masterLayer.add(layercollectables);
			masterLayer.add(layerladders);
			masterLayer.add(star-spriteGroup);
			masterLayer.add(Layer5Group);

			if ( addToStage )
				createObjects(onAddCallback, parentObject);

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 25000;
			boundsMaxY = 25000;
			boundsMin = new FlxPoint(0, 0);
			boundsMax = new FlxPoint(25000, 25000);
			bgColor = 0xff000000;
		}

		override public function createObjects(onAddCallback:Function = null, parentObject:Object = null):void
		{
			addPathsForLayerLayer5(onAddCallback);
			addSpritesForLayerstar-sprite(onAddCallback);
			generateObjectLinks(onAddCallback);
			if ( parentObject != null )
				parentObject.add(masterLayer);
			else
				FlxG.state.add(masterLayer);
		}

		public function addPathsForLayerLayer5(onAddCallback:Function = null):void
		{
			var pathobj:PathData;

			pathobj = new PathData( [ new FlxPoint(576.000, 12320.000),
				new FlxPoint(688.000, 12320.000),
				new FlxPoint(688.000, 12352.000),
				new FlxPoint(784.000, 12352.000),
				new FlxPoint(768.000, 12384.000),
				new FlxPoint(832.000, 12400.000),
				new FlxPoint(1024.000, 12400.000),
				new FlxPoint(1136.000, 12336.000),
				new FlxPoint(1200.000, 12368.000) 
			], false, false, Layer5Group );
			paths.push(pathobj);
			callbackNewData( pathobj, onAddCallback, Layer5Group, generateProperties( null ), 1, 1 );

		}

		public function addSpritesForLayerstar-sprite(onAddCallback:Function = null):void
		{
			addSpriteToLayer(null, Avatar, star-spriteGroup , 1200.000, 12368.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 1153.087, 12344.544, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 1107.048, 12352.544, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 1061.509, 12378.566, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 1014.751, 12400.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 962.301, 12400.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 909.852, 12400.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 857.402, 12400.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 805.760, 12393.440, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 774.050, 12371.900, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 753.799, 12352.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 701.349, 12352.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 680.900, 12320.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 628.450, 12320.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, Avatar, star-spriteGroup , 576.000, 12320.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//""
			addSpriteToLayer(null, star, star-spriteGroup , 32.000, 12400.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Stars"
			addSpriteToLayer(null, star, star-spriteGroup , 48.000, 12400.000, 0.000, 1, 1, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Stars"
		}

		public function generateObjectLinks(onAddCallback:Function = null):void
		{
		}

	}
}
