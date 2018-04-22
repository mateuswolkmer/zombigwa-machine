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

import objects.Player;
import objects.Zombie;
import objects.Zombie1;
import objects.Zombie2;
import utils.ZombieGenerator;

class PlayState extends FlxState {

	// TILEMAP
	private var map:TiledMap;
 	private var mBasics:FlxTilemap;
	private var mOverlay:FlxTilemap;
	private var mBottomWalls:FlxTilemap;
	private var mPlattform:FlxTilemap;

	public var player:Player;

	private var zombieGenerator:ZombieGenerator = new ZombieGenerator();

	private var grpZombies:FlxTypedGroup<Zombie> = new FlxTypedGroup<Zombie>();

	override public function create():Void	{
		super.create();

		FlxG.debugger.drawDebug = true;

		map = new TiledMap("assets/data/Level.tmx");

		mBasics = new FlxTilemap();
		mOverlay = new FlxTilemap();
		mBottomWalls = new FlxTilemap();
		mPlattform = new FlxTilemap();

		mBasics.loadMapFromArray(cast(map.getLayer("Basics"), TiledTileLayer).tileArray, map.width, map.height, AssetPaths.BasicTileset__png, map.tileWidth, map.tileHeight, OFF, 1, 1, 3);
		mOverlay.loadMapFromArray(cast(map.getLayer("Overlay"), TiledTileLayer).tileArray, map.width, map.height, AssetPaths.BasicTileset__png, map.tileWidth, map.tileHeight, OFF, 1, 1, 3);
		mBottomWalls.loadMapFromArray(cast(map.getLayer("Overlay 2"), TiledTileLayer).tileArray, map.width, map.height, AssetPaths.BasicTileset__png, map.tileWidth, map.tileHeight, OFF, 1, 1, 3);
		mPlattform.loadMapFromArray(cast(map.getLayer("Platform"), TiledTileLayer).tileArray, map.width, map.height, AssetPaths.BasicTileset__png, map.tileWidth, map.tileHeight, OFF, 1, 1, 3);
		
		mBasics.follow();
		
		mBasics.setTileProperties(3, FlxObject.ANY);
		mBottomWalls.setTileProperties(10, FlxObject.ANY);

		for (i in 2...16) mPlattform.setTileProperties(i, FlxObject.NONE);
		mPlattform.setTileProperties(1, FlxObject.ANY);
		
		add(mBasics);
		add(mOverlay);
		add(mPlattform);
		add(mBottomWalls);

		player =  new Player(310,30);
		add(player);

		grpZombies.add(zombieGenerator.create(1, 1));
		grpZombies.add(zombieGenerator.create(2, 3));
		grpZombies.add(zombieGenerator.create(1, 5));
		add(grpZombies);
	}

	override public function update(elapsed:Float):Void	{
		super.update(elapsed);

		FlxG.collide(player, mBasics);
		FlxG.collide(player, mBottomWalls);
		FlxG.collide(player, mPlattform);
		
        if(FlxG.mouse.justPressed)  
			grpZombies.forEachAlive(checkHit);
	}

	private function checkHit(z:Zombie):Void
	{
		// if (FlxG.mouse.getPosition.ray(z.getMidpoint(), player.getMidpoint()))
		// {
		// 	z.destroy;
		// }
	}
}