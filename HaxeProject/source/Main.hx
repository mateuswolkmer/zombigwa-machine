package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new() {
		super();
		
		// addChild(new FlxGame(352, 192, MenuState));
		addChild(new FlxGame(320, 192, MenuState));
		// addChild(new FlxGame(0, 0, PlayState));
	}
}
