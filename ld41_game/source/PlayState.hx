package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.FlxG;
import haxe.Timer;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxGroup;

import objects.*;
import utils.FormationParser;


class PlayState extends FlxState {

	// TILEMAP
	private var map:TiledMap;
 	private var mBasics:FlxTilemap;
	private var mWalls:FlxTilemap;
	private var mPlatformWalls:FlxTilemap;
	private var mSpikes:FlxTilemap;
	private var mBottomWalls:FlxTilemap;
	private var mPlatform:FlxTilemap;

	public var player:Player;
	private var brainMachine:BrainMachine;

	private var zombies:FlxGroup;
	private var heads:FlxGroup = new FlxGroup();

	override public function create():Void	{
		super.create();

		// FlxG.debugger.drawDebug = true;

		map = new TiledMap("assets/data/Level.tmx");

		mBasics = new FlxTilemap();
		mWalls = new FlxTilemap();
		mPlatformWalls = new FlxTilemap();
		mSpikes = new FlxTilemap();
		mBottomWalls = new FlxTilemap();
		mPlatform = new FlxTilemap();

		mBasics.loadMapFromArray(cast(map.getLayer("Basics"), TiledTileLayer).tileArray, map.width, map.height, AssetPaths.BasicTileset__png, map.tileWidth, map.tileHeight, OFF, 1, 1, 3);
		mWalls.loadMapFromArray(cast(map.getLayer("Walls"), TiledTileLayer).tileArray, map.width, map.height, AssetPaths.BasicTileset__png, map.tileWidth, map.tileHeight, OFF, 1, 1, 3);
		mPlatformWalls.loadMapFromArray(cast(map.getLayer("PlatformWalls"), TiledTileLayer).tileArray, map.width, map.height, AssetPaths.BasicTileset__png, map.tileWidth, map.tileHeight, OFF, 1, 1, 3);
		mSpikes.loadMapFromArray(cast(map.getLayer("Spikes"), TiledTileLayer).tileArray, map.width, map.height, AssetPaths.BasicTileset__png, map.tileWidth, map.tileHeight, OFF, 1, 1, 3);
		mBottomWalls.loadMapFromArray(cast(map.getLayer("BottomWalls"), TiledTileLayer).tileArray, map.width, map.height, AssetPaths.BasicTileset__png, map.tileWidth, map.tileHeight, OFF, 1, 1, 3);
		mPlatform.loadMapFromArray(cast(map.getLayer("Platform"), TiledTileLayer).tileArray, map.width, map.height, AssetPaths.BasicTileset__png, map.tileWidth, map.tileHeight, OFF, 1, 1, 3);
		
		mBasics.follow();
		

		for (i in 1...18) {
			mWalls.setTileProperties(i, FlxObject.ANY, projectileWallCollide, Projectile);
			mPlatformWalls.setTileProperties(i, FlxObject.ANY);
			mBottomWalls.setTileProperties(i, FlxObject.ANY, projectileWallCollide, Projectile);
			mSpikes.setTileProperties(i, FlxObject.ANY, projectileWallCollide, Projectile);

			mBasics.setTileProperties(i, FlxObject.NONE);
			mPlatform.setTileProperties(i, FlxObject.NONE);
		} 

		add(mBasics);
		add(mWalls);
		add(mPlatformWalls);
		add(mSpikes);
		add(mPlatform);
		add(mBottomWalls);

		player =  new Player(310,30);
		add(player);

		add(player.projectiles);

		brainMachine = new BrainMachine();
		add(brainMachine);


		zombies = FormationParser.parseStringAndGetZombies(FormationParser.firstFormation);

		add(zombies);
		add(heads);
	}

	private function projectileWallCollide(TILE:FlxObject, PROJECTILE:FlxObject):Void
	{
		var projectile:Projectile = cast PROJECTILE;
		projectile.kill();
	}

	override public function update(elapsed:Float):Void	{
		super.update(elapsed);

		if(FlxG.keys.justPressed.SPACE) FlxG.fullscreen = !FlxG.fullscreen;

		FlxG.collide(player, mWalls);
		FlxG.collide(player, mPlatformWalls);
		FlxG.collide(player, mBottomWalls);
		
		FlxG.collide(player.projectiles, mWalls);
		FlxG.collide(player.projectiles, mBottomWalls);
		FlxG.collide(player.projectiles, mSpikes);

		FlxG.overlap(player.projectiles, zombies, headCollideZombie);
	}

	private function headCollideZombie(projectile:Projectile, zombie:Zombie):Void {
		heads.add(new Head(zombie.x, zombie.y, projectile.dir));
		projectile.kill();
		zombie.kill();
	}
}