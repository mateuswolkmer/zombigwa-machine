package;

import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();
		add(new FlxText(10,10,100,"teataetsata"));
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
