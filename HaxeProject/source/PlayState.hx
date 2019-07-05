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
import flixel.tweens.FlxTween;

import flixel.util.FlxColor;
import flixel.FlxSprite;

import objects.*;
import utils.FormationParser;
import huds.HeadSequence;

using flixel.util.FlxSpriteUtil;


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
	private var headSequence:HeadSequence;

	private var zombies:FlxGroup;
	private var heads:FlxGroup = new FlxGroup();

	var triesTxt:FlxText = new FlxText();

	private var round:Int = 0;
	private var tries:Int = 3;

	override public function create():Void	{
		super.create();

		var sprite = new FlxSprite();
		sprite.makeGraphic(12, 12, FlxColor.TRANSPARENT);
		var mouseColor:FlxColor = new FlxColor();
		mouseColor.setRGB(0xE6, 0x48, 0x2E);
		sprite.drawCircle(-1, -1, -1, mouseColor);

		// Load the sprite's graphic to the cursor
		FlxG.mouse.load(sprite.pixels);
		FlxG.mouse.visible = true;

		// FlxG.debugger.drawDebug = true;

		map = new TiledMap("assets/data/LevelSmall.tmx");

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
			mWalls.setTileProperties(i, FlxObject.ANY); 
			mPlatformWalls.setTileProperties(i, FlxObject.ANY);
			mBottomWalls.setTileProperties(i, FlxObject.ANY);
			mSpikes.setTileProperties(i, FlxObject.ANY); 

			mBasics.setTileProperties(i, FlxObject.NONE);
			mPlatform.setTileProperties(i, FlxObject.NONE);
		} 

		add(mBasics);
		add(mWalls);
		add(mPlatformWalls);
		add(mSpikes);
		add(mPlatform);
		add(mBottomWalls);

		player =  new Player(285, FlxG.height / 2 - 8);
		add(player);

		add(player.projectiles);

		startSequence();

		add(heads);

		triesTxt.setFormat(null, 16, 0xE6482E);
		triesTxt.text = "" + tries;
		triesTxt.setPosition(FlxG.width - 14, FlxG.height / 2 - 8);
		add(triesTxt);

		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			FlxG.sound.playMusic(AssetPaths.ld41_background__ogg, 1, true);
		}
	}

	private function startSequence():Void {
		if(headSequence != null) remove(headSequence, true);
		if(headSequence != null) remove(headSequence.allHeads, true);
		if(brainMachine != null) remove(brainMachine, true);
		if(zombies != null) remove(zombies, true);

		headSequence = new HeadSequence(FormationParser.sequences[round]);
		brainMachine = new BrainMachine(headSequence);
		zombies = FormationParser.parseStringAndGetZombies(FormationParser.formations[round]);
		
		add(headSequence);
		add(headSequence.allHeads);
		add(brainMachine);
		add(zombies);

		triesTxt.text = "" + tries;
	}

	override public function update(elapsed:Float):Void	{
		super.update(elapsed);

		if(FlxG.keys.justPressed.SPACE) FlxG.fullscreen = !FlxG.fullscreen;

		FlxG.collide(player, mWalls);
		FlxG.collide(player, mPlatformWalls);
		FlxG.collide(player, mBottomWalls);
		
		FlxG.collide(player.projectiles, mWalls, projectileCollideWall);
		FlxG.collide(player.projectiles, mBottomWalls, projectileCollideWall);
		FlxG.collide(player.projectiles, mSpikes, projectileCollideWall);

		FlxG.overlap(player.projectiles, zombies, projectileOverlapZombie);
		FlxG.overlap(heads, brainMachine, headOverlapBrainmachine);

		FlxG.collide(heads, mWalls, headCollideWall);
		FlxG.collide(heads, mBottomWalls, headCollideWall);
		FlxG.collide(heads, mSpikes, headCollideSpikes);

		FlxG.collide(heads, zombies, headCollideZombie);

		if(headSequence.openHeads.length == 0) {
			if(++round == FormationParser.sequences.length) openSubState(new GameOver(true));
			else {
				displayInfoText("Next Sequence");
				startSequence();
			}
		}
		if(headSequence.wrongHead || noZombiesLeft() || zombiesOutOfScreen()) {
			if(--tries == 0) openSubState(new GameOver(false));
			else {
				if(headSequence.wrongHead) displayInfoText("This was a wrong Head");
				else if(noZombiesLeft()) displayInfoText("No Zombies Left");
				else if(zombiesOutOfScreen()) displayInfoText("All Zombies are gone");
				
				startSequence();
			}
		} 
	}

	private function noZombiesLeft():Bool {
		return (zombies.countLiving() == 0 && heads.countLiving() == 0);
	}

	private function zombiesOutOfScreen():Bool {
		var outOfScreen:Bool = true;
		zombies.forEachAlive( function(zombie) {
			var isZombie:Zombie = cast zombie;
			if(isZombie.y < FlxG.height) outOfScreen = false;
		});
		return (outOfScreen && heads.countLiving() == 0);
	}

	private function displayInfoText(text:String):Void {
		var countDownTxt:FlxText = new FlxText(0, 28, FlxG.width);
		countDownTxt.setFormat(null, 16, 0xE6482E, FlxTextAlign.CENTER);
		countDownTxt.text = text;
		add(countDownTxt);

		FlxTween.tween(countDownTxt, {y: -100}, 3, {type:FlxTween.ONESHOT, startDelay: 2}).onComplete = function(t:FlxTween):Void
		{
			remove(countDownTxt);
		}
	}

	private function projectileCollideWall(projectile:Projectile, tiles:FlxTilemap):Void
	{
		projectile.kill();
	}

	private function projectileOverlapZombie(projectile:Projectile, zombie:Zombie):Void {
		heads.add(new Head(zombie.x, zombie.y, projectile.dir, zombie.type));
		projectile.kill();
		zombie.kill();
	}

	private function headOverlapBrainmachine(head:Head, brainMachine:BrainMachine):Void {
		brainMachine.headHitCheck(head);
		head.kill();
	}

	private function headCollideWall(head:Head, tiles:FlxTilemap):Void {
		if(head.touching == FlxObject.UP || head.touching == FlxObject.DOWN) head.dir.y *= -1;
		if(head.touching == FlxObject.RIGHT || head.touching == FlxObject.LEFT) head.dir.x *= -1;
	}

	private function headCollideSpikes(head:Head, tiles:FlxTilemap):Void {
		head.kill();
	}

	private function headCollideZombie(head:Head, zombie:Zombie):Void {
		head.kill();
		zombie.kill();
	}
}