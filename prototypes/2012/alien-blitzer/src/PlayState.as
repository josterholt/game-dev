package  
{
	import flash.display.InteractiveObject;
	import flash.geom.Rectangle;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class PlayState extends FlxState
	{
		[Embed(source = "/../assets/terrain/PlayerGraphic.png")] public var playerImg:Class;
		[Embed(source = "/../assets/terrain/Rock.png")] public var enemyImg:Class;
		[Embed(source = "/../maps/mapCSV_Level1_terrain.csv", mimeType = "application/octet-stream")] public var level1CSV:Class;
		[Embed(source = "/../maps/mapCSV_Level1_water.csv", mimeType = "application/octet-stream")] public var waterCSV:Class;		
		[Embed(source = "/../maps/mapCSV_Level1_enemies.csv", mimeType = "application/octet-stream")] public var enemiesCSV:Class;
		[Embed(source = "/../maps/mapCSV_Level1_ammo.csv", mimeType = "application/octet-stream")] public var ammoStockCSV:Class;		
		[Embed(source = "/../assets/floor1.png")] public var floorImg:Class;
	
		
		// HUD Images
		[Embed(source = "/../assets/Ammo.png")] public var ammoImg:Class;
		public var ammoClip:FlxGroup;
		public var ammoSpr:FlxSprite;
		
		[Embed(source = "/../assets/HealthBar.png")] public var healthImg:Class;		
		public var healthSpr:FlxSprite;
		
		[Embed(source = "/../assets/HUD_background.png")] public var hudImg:Class;
		public var hudSpr:FlxSprite;
		
		[Embed(source = "/../assets/PlayerPic.png")] public var playerIconImg:Class;
		public var playerSpr:FlxSprite;
		
		[Embed(source = "/../assets/Text_ammo.png")] public var ammoTxtImg:Class;
		public var ammoTxtSpr:FlxSprite;
		
		[Embed(source = "/../assets/Text_health.png")] public var healthTxtImg:Class;		
		public var healthTxtSpr:FlxSprite;
		
		[Embed(source = "/../assets/Text_weapon.png")] public var weaponTxtImg:Class;		
		public var weaponTxtSpr:FlxSprite;
		
		[Embed(source = "/../assets/Weapon_hammer.png")] public var hammerIconImg:Class;		
		public var hammerIconSpr:FlxSprite;
		
	

		public var player:FlxSprite;
		public var enemy:FlxSprite;
		public var enemies:FlxGroup;
		public var ammoStocks:FlxGroup;
		public var level:FlxTilemap;
		public var water:FlxTilemap;
		public var enemyDirection:String
		public var playerHealthTxt:FlxText;
		public var playerHealth:int;
		
		public var playerWeapon:FlxWeapon;
		public var playerAmmo:int;
		public var playerWeaponName:String;
		public var walkingOnWater:Boolean;

		
		override public function create():void
		{			
			// WALLS
			level = new FlxTilemap;
			level.loadMap(new level1CSV, floorImg, 25, 25, 0, 0, 1, 4);
			add(level);
			
			water = new FlxTilemap;
			water.loadMap(new waterCSV, floorImg, 25, 25, 0, 0, 1, 4);
			add(water);	

			
			/*
			wall = new FlxTileblock(0, 0, 1000, 10);
			wall.makeGraphic(1000, 10, 0xffffffff);
			add(wall);
			*/

			// Ammo Stock
			ammoStocks = new FlxGroup;
			var tmpMap:FlxTilemap = new FlxTilemap;
			tmpMap.loadMap(new ammoStockCSV, ammoImg, 50, 50, 0, 0, 1, 1);
			for (var ty:int = 0; ty < tmpMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < tmpMap.widthInTiles; tx++)
				{
					if (tmpMap.getTile(tx, ty) == 1)
					{
						ammoStocks.add(new FlxSprite(tx * 50, ty * 50, ammoImg));
					}
				}
			}
			add(ammoStocks);			
			
			// PLAYER
			player = new FlxSprite(50, 250);
			player.facing = FlxObject.RIGHT;			
			player.loadGraphic(playerImg, false, true, 72, 52);
			
			// Weapon
			playerWeapon = new FlxWeapon("Stick", player, "x", "y");
			playerWeapon.bulletLifeSpan = 1500;
			playerWeapon.setBulletBounds(new FlxRect(0, 0, level.width, level.height));
			playerWeapon.makePixelBullet(10, 5, 5, 0xff0000ff, 50, 25);
			playerWeapon.setBulletDirection(FlxWeapon.BULLET_RIGHT, 300);
			add(playerWeapon.group);
			
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}			
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN);
			FlxG.worldBounds = new FlxRect(0, 0, level.width, level.height);
			FlxG.camera.setBounds(0, 200, level.width, level.height);
			
			FlxControl.create(player, FlxControlHandler.MOVEMENT_INSTANT, FlxControlHandler.STOPPING_INSTANT, 1, true, true);
			FlxControl.player1.setCursorControl(true, true, true, true);
			FlxControl.player1.setBounds(0, 0, level.width, level.height);
			//FlxControl.player1.setStandardSpeed(100, true);
			FlxControl.player1.setMovementSpeed(100, 100, 100, 100, 100, 100);
			FlxControl.player1.setFireButton("CONTROL", FlxControlHandler.KEYMODE_PRESSED, 450, fireWeapon);
			add(player);
			
			// ENEMY
			enemies = new FlxGroup;
			parseEnemies(enemiesCSV, enemyImg);
			
			/*
			enemy = new FlxSprite(100, 100, enemyImg);
			enemyDirection = "LEFT";
			add(enemy);
			*/
			
			// HUD
			/*
			playerHealth = 100;
			playerHealthTxt = new FlxText(10, 10, 300);
			playerHealthTxt.color = 0xffffff;
			playerHealthTxt.shadow = 0xff0000;
			playerHealthTxt.scrollFactor.x = 0;
			playerHealthTxt.scrollFactor.y = 0;
			playerHealthTxt.size = 12;
			playerHealthTxt.text = "Health: " + playerHealth + "/100";
			add(playerHealthTxt);
			*/
			
			hudSpr = new FlxSprite(50, 450, hudImg);
			hudSpr.scrollFactor.x = 0;
			hudSpr.scrollFactor.y = 0;
			add(hudSpr);
			
			ammoClip = new FlxGroup;
			var padding:int = 10;

			for (var i:int = 15; i > 0; i--)
			{
				ammoSpr = new FlxSprite((300 + padding * i), 540, ammoImg);
				ammoSpr.scrollFactor.x = 0;
				ammoSpr.scrollFactor.y = 0;
				ammoClip.add(ammoSpr);
			}
			add(ammoClip);
			
			ammoTxtSpr = new FlxSprite(300, 510, ammoTxtImg);
			ammoTxtSpr.scrollFactor.x = 0;
			ammoTxtSpr.scrollFactor.y = 0;
			add(ammoTxtSpr);
			
			weaponTxtSpr = new FlxSprite(490, 505, weaponTxtImg);
			weaponTxtSpr.scrollFactor.x = 0;
			weaponTxtSpr.scrollFactor.y = 0;
			add(weaponTxtSpr);
			
			hammerIconSpr = new FlxSprite(500, 530, hammerIconImg);			
			hammerIconSpr.scrollFactor.x = 0;
			hammerIconSpr.scrollFactor.y = 0;
			add(hammerIconSpr);
			
			healthSpr = new FlxSprite(70, 540, healthImg);
			healthSpr.scrollFactor.x = 0;
			healthSpr.scrollFactor.y = 0;
			add(healthSpr);
			
			healthTxtSpr = new FlxSprite(65, 510, healthTxtImg);			
			healthTxtSpr.scrollFactor.x = 0;
			healthTxtSpr.scrollFactor.y = 0;
			add(healthTxtSpr);

			playerSpr = new FlxSprite(600, 465, playerIconImg);
			playerSpr.scrollFactor.x = 0;
			playerSpr.scrollFactor.y = 0;
			add(playerSpr);			
		}
		
		public function fireWeapon():void
		{
			/*
			var members:Array = ammoClip.members;
			for (var i:int = 0; i < members.length; i++)
			{
				if (members[i] != undefined)
				{
					trace(members[i].alive);
				}

			}
			ammoClip.
			*/
			if (ammoClip.countLiving() > 0) 
			{
				var ammo:FlxBasic = ammoClip.getFirstAlive();
				ammo.kill();
				playerWeapon.fire();
			}
		}
		override public function update():void
		{
			super.update();
			walkingOnWater = false;
			//FlxG.overlap(player, water, slowWalking, processTileMap);
			FlxG.collide(player, level);
			FlxG.overlap(player, ammoStocks, collectAmmo);			
			FlxG.collide(player, enemies, hurtPlayer);
			FlxG.collide(playerWeapon.group, enemies, hurtEnemy);

			/*
			if (walkingOnWater == false)
			{
				FlxControl.player1.setStandardSpeed(100);
			} else {
				FlxControl.player1.setStandardSpeed(50);
			}
			*/
			enemyMove();
		}
		
		public function slowWalking(obj1:FlxBasic, obj2:FlxBasic):void
		{
			walkingOnWater = true;
		}
		
		public function collectAmmo(obj1:FlxBasic, obj2:FlxBasic):void
		{
			if (ammoClip.countDead() > 0)
			{
				var ammo:FlxBasic = ammoClip.getFirstDead();
				ammo.revive();
				obj2.kill();
			}
		}
		
		public function hurtPlayer(obj1:FlxBasic, obj2:FlxBasic):void
		{
			player.flicker(2);
			playerHealth -= 5;
			//playerHealthTxt.text = "Health: " + playerHealth + "/100";
			//playerHealthTxt.flicker();
			healthSpr.width = healthSpr.width * .75;
			playerSpr.flicker();
			//enemy.kill();

		}
		
		public function hurtEnemy(obj1:FlxBasic, obj2:FlxBasic):void
		{
			obj1.kill();
			obj2.kill();
		}
		
		public function enemyMove():void
		{
			var members:Array = enemies.members;

			for (var i:int = 0; i < members.length; i++)
			{
				if (members[i] != undefined)
				{
					if ((members[i].x - player.x) < 800)
					{
						members[i].x -= 5;
					}					
				}
				/*
				if ((player.x - members[i].x) < 100)
				{
					members[i].x -= 5;
				}
				*/
			}

			//trace(FlxG.camera.bounds.x + "/" + FlxG.camera.bounds.y);
			/*
			if(enemy.x <= 0) 
			{
				enemyDirection = "RIGHT";
			} else if (enemy.x >= 150) {
				enemyDirection = "LEFT";
			}
			*/
			/*
			if (enemyDirection == "RIGHT")
			{
				enemy.x += 2;
			} else {
				enemy.x -= 2;				
			}
			*/

			//trace(enemyDirection);
			//trace(enemy.x);
		}
		
		public function parseEnemies(enemiesCSV:Object, spr:Class):void
		{
				var tmpMap:FlxTilemap = new FlxTilemap;
				tmpMap.loadMap(new enemiesCSV, enemyImg, 50, 50, 0, 0, 1, 1);
				for (var ty:int = 0; ty < tmpMap.heightInTiles; ty++)
				{
					for (var tx:int = 0; tx < tmpMap.widthInTiles; tx++)
					{
						if (tmpMap.getTile(tx, ty) == 1)
						{
							enemies.add(new FlxSprite(tx * 50, ty * 50, enemyImg));
						}
					}
				}
				add(enemies);
				
		}
		
		
	}
	
	

}