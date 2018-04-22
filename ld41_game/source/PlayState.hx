package;

import flixel.FlxState;
import flixel.text.FlxText;
import haxe.Timer;

import objects.Player;
import objects.Zombie;
import utils.ZombieGenerator;

class PlayState extends FlxState {

	public var player:Player = new Player(900,10);
	private var zombieGenerator:ZombieGenerator = new ZombieGenerator();

	override public function create():Void	{
		super.create();

		add(player);

		add(zombieGenerator.create(1, 1));
		add(zombieGenerator.create(2, 5));
	}

	override public function update(elapsed:Float):Void	{
		super.update(elapsed);
	}
}
