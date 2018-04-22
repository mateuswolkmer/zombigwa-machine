package;

import flixel.FlxState;
import flixel.text.FlxText;
import haxe.Timer;

import objects.Player;
import objects.Zombie1;
import objects.Zombie2;
import utils.ZombieGenerator;

class PlayState extends FlxState {

	public var player:Player;
	private var zombieGenerator:ZombieGenerator;

	override public function create():Void	{
		super.create();

		player =  new Player(900,10);
		add(player);

		zombieGenerator = new ZombieGenerator(this);
		zombieGenerator.create(1, 1);
		zombieGenerator.create(2, 5);
	}

	override public function update(elapsed:Float):Void	{
		super.update(elapsed);
	}
}
