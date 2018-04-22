package;

import flixel.FlxState;
import flixel.text.FlxText;
import haxe.Timer;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxG;

import objects.Player;
<<<<<<< HEAD
import objects.Zombie1;
import objects.Zombie2;
// import utils.ZombieGenerator;

class PlayState extends FlxState {

	// TILEMAP
	private var map:TiledMap;
 	private var mBasics:FlxTilemap;
	private var mOverlay:FlxTilemap;
	private var mBottomWalls:FlxTilemap;
	private var mPlattform:FlxTilemap;

	public var player:Player;
	// private var zombieGenerator:ZombieGenerator;
=======
import objects.Zombie;
import utils.ZombieGenerator;

class PlayState extends FlxState {

	public var player:Player = new Player(900,10);
	private var zombieGenerator:ZombieGenerator = new ZombieGenerator();
>>>>>>> c7e2139f5c78bbd82643dbb68b48768d91d7352b

	override public function create():Void	{
		super.create();

<<<<<<< HEAD
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
		// zombieGenerator = new ZombieGenerator(this);
		// zombieGenerator.create(1, 1);
		// zombieGenerator.create(2, 5);
=======
		add(player);

		add(zombieGenerator.create(1, 1));
		add(zombieGenerator.create(2, 5));
>>>>>>> c7e2139f5c78bbd82643dbb68b48768d91d7352b
	}

	override public function update(elapsed:Float):Void	{
		super.update(elapsed);

		 FlxG.collide(player, mBasics);
		 FlxG.collide(player, mBottomWalls);
		 FlxG.collide(player, mPlattform);
	}
}
