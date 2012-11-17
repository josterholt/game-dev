package 
{
	import flash.events.TimerEvent;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Timer;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	
	public class PlayState extends FlxState
	{
		[Embed(source = "/../assets/player.png")] public var playerImg:Class;
		[Embed(source = "/../map/mapCSV_Level1_terrain.csv", mimeType = "application/octet-stream")] public var mapCSV:Class;
		//[Embed(source = "/../map/mapCSV_Level1_collectables.csv", mimeType = "application/octet-stream")] public var collectablesCSV:Class;
		[Embed(source = "/../map/mapCSV_Laddders_1.csv", mimeType = "application/octet-stream")] public var laddersCSV:Class;
		[Embed(source = "/../map/mapCSV_Baddies_Map1.csv", mimeType = "application/octet-stream")] public var baddiesCSV:Class;
		[Embed(source = "/../map/mapCSV_BaddyCmds_1.csv", mimeType = "application/octet-stream")] public var baddyCmdCSV:Class;
		[Embed(source = "/../assets/platform0.png")] public var mapTilesPNG:Class;
		[Embed(source = "/../assets/collectables.png")] public var collectablesPNG:Class;
		[Embed(source = "/../assets/star.png")] public var starPNG:Class;
		[Embed(source = "/../assets/bullet.png")] public var bulletPNG:Class;
		[Embed(source = "/../assets/ladder.png")] public var ladderPNG:Class;
		[Embed(source = "/../assets/baddy1.png")] public var baddies1PNG:Class;
		[Embed(source = "/../assets/baddy2.png")] public var baddies2PNG:Class;
		[Embed(source = "/../assets/baddy3.png")] public var baddies3PNG:Class;		

		// Game timer
		public var timerTxt:FlxText;

		
		public var player:FlxSprite;
		public var level:FlxGroup;
		public var collectables:FlxGroup;
		public var map:FlxTilemap;
		public var ladderMap:FlxTilemap;
		public var ladders:FlxGroup;
		public var collectablesMap:FlxTilemap;
		public var gun:FlxWeapon;
		public var deadStars:Array;
		public var curRound:int;
		public var reviveRound:int;
		
		public var gameTimer:Timer;
		public var gameTimerTotalSeconds:int;
		public var gameTimerSeconds:int;		
		
		public var climbing:Boolean = false;
		public var ladder:Boolean = false;
		
		public var baddyReverseMap:FlxGroup;
		public var baddies1:FlxGroup;
		public var baddies2:FlxGroup;
		public var endMarker:FlxSprite;
		public var gravity:Boolean;
		
		public var dark:FlxSprite;
		public var dark_offset:int;
		
		public function PlayState() 
		{

		}

		protected function onGameTimerTick( event:TimerEvent ):void
		{
			gameTimerSeconds--;
			if (gameTimerSeconds > 0) {
				timerTxt.text = "Time: " + gameTimerSeconds.toString();
			} else {
				gameTimer.stop();
				FlxG.switchState(new LoseState);
			}
		}

		override public function create():void
		{	
			gravity = true;
			// Game timer
			gameTimerTotalSeconds = 60;
			gameTimerSeconds = 60;
			timerTxt = new FlxText(25, 10, 200, "Timer: 0");

			timerTxt.color = 0xffffff;
			timerTxt.shadow = 0xff0000;
			timerTxt.scrollFactor.x = 0;
			timerTxt.scrollFactor.y = 0;
			timerTxt.size = 18;
			add(timerTxt);
			
			gameTimer = new Timer(1000);
			gameTimer.addEventListener(TimerEvent.TIMER, onGameTimerTick );
			gameTimer.start();
	
			curRound = 0;
			reviveRound = 1000;
			
			level = new FlxGroup;
			
			map = new FlxTilemap;
			map.loadMap(new mapCSV, mapTilesPNG, 25, 25, 0, 0, 1, 2);
			map.setTileProperties(1, FlxObject.UP); // , null, null, 1000);
			//map.setTileProperties(40, FlxObject.UP, null, null, 4);
			level.add(map);
			add(level);
			
			var tmpMap:FlxTilemap;
			
			baddyReverseMap = new FlxGroup;
			
			tmpMap = new FlxTilemap;
			tmpMap.loadMap(new baddyCmdCSV, mapTilesPNG, 25, 25, 0, 0, 1, 1);
			for (var ty:int = 0; ty < tmpMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < tmpMap.widthInTiles; tx++)
				{
					if (tmpMap.getTile(tx, ty) == 1)
					{				
						var spr:FlxSprite = new FlxSprite(tx * 25, ty * 25, mapTilesPNG)
						spr.immovable = true;
						//baddyReverseMap.add(spr);
					}
				}
			}			
			//add(baddyReverseMap);
			
			baddies1 = new FlxGroup;
			baddies2 = new FlxGroup;
			tmpMap = new FlxTilemap;
			tmpMap.loadMap(new baddiesCSV, baddies1PNG, 25, 25, 0, 0, 1, 1);
			for (var ty:int = 0; ty < tmpMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < tmpMap.widthInTiles; tx++)
				{
					if (tmpMap.getTile(tx, ty) == 1)
					{
						var baddy:FlxSprite = new FlxSprite(tx * 25, ty * 25, baddies1PNG);
						baddy.velocity.y = -200;
						baddies1.add(baddy);
					}
					if (tmpMap.getTile(tx, ty) == 2) 
					{
						var baddy:FlxSprite = new FlxSprite(tx * 25, ty * 25, baddies2PNG);
						baddy.velocity.y = -200;
						baddies2.add(baddy);
					}
					if (tmpMap.getTile(tx, ty) == 3) {
						endMarker = new FlxSprite(tx * 25, ty * 25, baddies3PNG);
						add(endMarker);
					}
				}
			}
			add(baddies1);
			add(baddies2);
			

			ladderMap = new FlxTilemap;
			ladders = new FlxGroup;
			ladderMap.loadMap(new laddersCSV, mapTilesPNG, 25, 25, 0, 0, 1, 3);
			for (var ty:int = 0; ty < ladderMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < ladderMap.widthInTiles; tx++)
				{
					if (ladderMap.getTile(tx, ty) == 2)
					{
						ladders.add(new FlxSprite(tx * 25, ty * 25, ladderPNG));
					}
				}
			}			
			add(ladders);
			
			FlxG.worldBounds = new FlxRect(0, 0, map.width, map.height); // FlxRect(800, 1000, -1000, -1000);
			FlxG.camera.setBounds(0, 0, map.width, map.height);

			player = new FlxSprite(50, (map.height - 100), playerImg);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);


			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
			FlxControl.create(player, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
			FlxControl.player1.setCursorControl(false, false, true, true);
			FlxControl.player1.setBounds(0, 0, map.width, map.height);
			FlxControl.player1.setMovementSpeed(400, 0, 100, 200, 400, 0);
			FlxControl.player1.setGravity(0, 400);
			FlxControl.player1.setJumpButton("UP", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 200);
			add(player);
			
			FlxG.mouse.show();
			
			dark_offset = 100;
			dark = new FlxSprite();
			dark.x = map.x;
			dark.y = map.y + map.height + dark_offset;
			dark.makeGraphic(map.width, map.height, 0xff999999);
			add(dark);
		}
		
		
		override public function update():void
		{
			super.update();
			ladder = false;
			if (player.y > map.height) {
				gameTimer.stop();
				FlxG.switchState(new LoseState);
			}
			
			dark.y = (map.height + dark_offset) - ((map.height + dark_offset) / gameTimerTotalSeconds) * (gameTimerTotalSeconds - gameTimerSeconds);

			FlxG.collide(player, level);
			FlxG.overlap(player, dark, loseGame);
			FlxG.collide(baddies1, level, baddyJump);
			FlxG.collide(baddies2, level, baddyJump);
			
			FlxG.overlap(player, baddies1, baddy1Collide);
			FlxG.overlap(player, baddies2, baddy2Collide);
			FlxG.overlap(player, endMarker, winGame);
			FlxG.overlap(player, ladders, enableClimb);
			
			FlxG.collide(baddies1, baddyReverseMap, reverseBaddyDirection);
			FlxG.collide(baddies2, baddyReverseMap, reverseBaddyDirection);
			
			if (ladder == false && climbing == true) {
				FlxControl.player1.setCursorControl(false, false, true, true);
				FlxControl.player1.setMovementSpeed(400, 0, 100, 200, 400, 0);
				FlxControl.player1.setGravity(0, 400);				
				climbing = false;
				gravity = true;
			}
			
			var baddy:FlxSprite;
			var baddy_gravity:int = 100;
			for (var i:int = 0; i < baddies1.members.length; i++) {
				baddy = baddies1.members[i] as FlxSprite;
				if (baddy != undefined) {
					baddy.velocity.y += 10;
				}
			}
			
			for (var i:int = 0; i < baddies2.members.length; i++) {
				baddy = baddies2.members[i] as FlxSprite;
				if (baddy != undefined) {
					baddy.velocity.y += 10;
				}
			}			

		}
		
		public function loseGame(player:FlxSprite, dark:FlxSprite):void {
			gameTimer.stop();
			FlxG.switchState(new LoseState);
		}
		
		public function baddyJump(baddy:FlxSprite, level:FlxBasic) {
			var rnd:int = Math.round(Math.random() * 1000);
			//trace(rnd);
			if(rnd < 10) {
				baddy.velocity.y = -200;
			}
		}
		
		public function baddy1Collide(player:FlxSprite, baddy:FlxSprite):void {
			baddy.velocity.x = 0;
			baddy.velocity.y = 0;

			if ((player.y + player.height) < (baddy.y + baddy.height)) {
				gameTimerSeconds += 2;
				baddy.kill();
			} else {		
				trace((player.y + player.height) + '/' + baddy.y)
				knockPlayer(player, baddy);
			}
		}
		
		public function baddy2Collide(player:FlxSprite, baddy:FlxSprite):void {
			baddy.velocity.x = 0;
			baddy.velocity.y = 0;
			if ((player.y + player.height) < (baddy.y + baddy.height)) {
				gameTimerSeconds -= 5;
				baddy.kill();
			} else {
				trace((player.y + player.height) + '/' + baddy.y)				
				knockPlayer(player, baddy);
			}
		}
		
		public function reverseBaddyDirection(baddy:FlxSprite, tile:FlxBasic):void {
			//trace(baddy.velocity.x + "/" + (baddy.velocity.x * -1))
			//baddy.velocity.x = baddy_velocity  * -1;
		}
		
		public function knockPlayer(player:FlxSprite, baddy:FlxSprite) {
				player.flicker(2);
				gameTimerSeconds += 2;				
				if(baddy.x > player.x) {
					player.velocity.x -= 20;
				} else {
					player.velocity.x += 20;
				}			
		}
		
		public function enableClimb(obj1:FlxBasic, obj2:FlxBasic):void
		{
			ladder = true;
			//if (climbing == false && FlxG.keys.UP == true) {
			if (climbing == false || gravity == true) {
				FlxControl.player1.setCursorControl(true, true, true, true);
				FlxControl.player1.setMovementSpeed(400, 400, 100, 200, 400, 400);
				FlxControl.player1.setGravity(0, 0);
				climbing = true;
				gravity = false;
			}
		}
		
		public function winGame(obj1:FlxBasic, obj2:FlxBasic) {
			gameTimer.stop();
			FlxG.switchState( new WinState() );
		}
		
		/**
		 * Draw a circle to a sprite.
		 *
		 * @param   Sprite          The FlxSprite to draw to
		 * @param   Center          x,y coordinates of the circle's center
		 * @param   Radius          Radius in pixels
		 * @param   LineColor       Outline color
		 * @param   LineThickness   Outline thickness
		 * @param   FillColor       Fill color
		 */
		public function drawCircle(Sprite:FlxSprite, Center:FlxPoint, Radius:Number = 30, LineColor:uint = 0xffffffff, LineThickness:uint = 1, FillColor:uint = 0xffffffff):void {
		 
			var gfx:Graphics = FlxG.flashGfx;
			gfx.clear();
		 
			// Line alpha
			var alphaComponent:Number = Number((LineColor >> 24) & 0xFF) / 255;
			if(alphaComponent <= 0)
				alphaComponent = 1;
		 
			gfx.lineStyle(LineThickness, LineColor, alphaComponent);
		 
			// Fill alpha
			alphaComponent = Number((FillColor >> 24) & 0xFF) / 255;
			if(alphaComponent <= 0)
				alphaComponent = 1;
		 
			gfx.beginFill(FillColor & 0x00ffffff, alphaComponent);
		 
			gfx.drawCircle(Center.x, Center.y, Radius);
		 
			gfx.endFill();
		 
			Sprite.pixels.draw(FlxG.flashGfxSprite);
			Sprite.dirty = true;
		}
	}
}