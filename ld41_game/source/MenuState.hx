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
        var title:FlxText = new FlxText(0, 8, FlxG.width);
		title.setFormat(null, 24, 0xE6482E, FlxTextAlign.CENTER);
        title.text = "Zombigma Machine";

		add(title);

        var infoP1:FlxText = new FlxText(0, 60, FlxG.width);
		infoP1.setFormat(null, 8, 0xFFFFFF, FlxTextAlign.CENTER);
		infoP1.text =   "You have to close a gate.\nOtherwise Zombies will get in your base.\n" + 
                        "To close the gate you have to get a machine running.\n This machine needs Zombieblood.\n" +
                        "BUT it wants a specific sequence of Zombie-Types\n\n" + 
                        "(Sequence is left on screen from bottom to top)";
		add(infoP1);

		super.create();

        var infoP2:FlxText = new FlxText(0, FlxG.height - 30, FlxG.width);
		infoP2.setFormat(null, 16, 0xE6482E, FlxTextAlign.CENTER);
		infoP2.text = "Press Enter to Start the Game";
		add(infoP2);

		super.create();
	}

	override public function update(elapsed:Float):Void	{
        if(FlxG.keys.justPressed.SPACE) FlxG.fullscreen = !FlxG.fullscreen;

		if(FlxG.keys.justPressed.ENTER) {
			startGame();
		} 

		super.update(elapsed);
	}

    // Changes the scene 
    private function startGame():Void {
        FlxG.switchState(new PlayState());
    }
}