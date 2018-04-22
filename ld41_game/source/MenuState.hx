package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.math.FlxPoint;

class MenuState extends FlxState {

    private var btnPlay:FlxButton;

	override public function create():Void {
        // Create and scale button
        btnPlay = new FlxButton(0,0,"Play",clickPlay);
        btnPlay.scale.x = btnPlay.scale.y = 5;
        btnPlay.updateHitbox();
        btnPlay.label.scale.x = btnPlay.label.scale.y = 5;
        btnPlay.label.updateHitbox();
        btnPlay.screenCenter();
        add(btnPlay);

		super.create();
	}

	override public function update(elapsed:Float):Void	{
		super.update(elapsed);
	}

    // Changes the scene 
    private function clickPlay():Void {
        FlxG.switchState(new PlayState());
    }
}