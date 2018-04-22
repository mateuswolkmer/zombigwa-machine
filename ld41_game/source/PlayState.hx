package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.FlxG;
import haxe.Timer;

import objects.Player;
import objects.Zombie;
import utils.ZombieGenerator;

class PlayState extends FlxState {

	public var player:Player = new Player(900,10);
	private var zombieGenerator:ZombieGenerator = new ZombieGenerator();

	private var grpZombies:FlxTypedGroup<Zombie> = new FlxTypedGroup<Zombie>();

	override public function create():Void	{
		super.create();

		add(player);

		grpZombies.add(zombieGenerator.create(1, 1));
		grpZombies.add(zombieGenerator.create(2, 3));
		grpZombies.add(zombieGenerator.create(1, 5));
		add(grpZombies);
	}

	override public function update(elapsed:Float):Void	{
		super.update(elapsed);
        if(FlxG.mouse.justPressed)  
			grpZombies.forEachAlive(checkHit);
	}

	private function checkHit(z:Zombie):Void
	{
		if (FlxG.mouse.getPosition.ray(z.getMidpoint(), player.getMidpoint()))
		{
			z.destroy;
		}
	}
}