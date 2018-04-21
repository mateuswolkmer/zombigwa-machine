package;

import flixel.FlxState;
import flixel.text.FlxText;

import objects.Player;

class PlayState extends FlxState {

	private var player:Player;

	override public function create():Void	{
		super.create();

		player =  new Player(20,500);
		add(player);
	}

	override public function update(elapsed:Float):Void	{
		super.update(elapsed);
	}
}
