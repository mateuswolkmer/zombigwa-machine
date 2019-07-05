package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

import tts.settings.*;
import tts.input.*;

class GameOver extends FlxSubState
{
	
	public function new (won:Bool) 
	{
		super();
		addOverlay();

		addWinnerText(won);

		addInformationText();
	}

	private function addOverlay():Void 
	{
		var overlay:FlxSprite = new FlxSprite();
		overlay.makeGraphic(FlxG.width, FlxG.height, 0x99000000);
		add(overlay);
	}
	private var textHeightReferencePoint:Float = (FlxG.height / 2) - 32;
	private function addWinnerText(won:Bool):Void
	{
		var title:FlxText = new FlxText(0, textHeightReferencePoint, FlxG.width);
		title.setFormat(null, 32, 0xE6482E, FlxTextAlign.CENTER);

        
        if(won) title.text = "You Won";
        else title.text = "You Lost";

		add(title);
	}
	private function addInformationText():Void
	{
		var infoP1:FlxText = new FlxText(0, textHeightReferencePoint + 40, FlxG.width);
		infoP1.setFormat(null, 16, 0xFFFFFF, FlxTextAlign.CENTER);
		infoP1.text = "Press Enter to Play Again";
		add(infoP1);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if(FlxG.keys.justPressed.SPACE) FlxG.fullscreen = !FlxG.fullscreen;

		if(FlxG.keys.justPressed.ENTER) {
			close();
		} 
		super.update(elapsed);
	}
	
	override public function close():Void 
	{
        FlxG.switchState(new PlayState());
	}
	
}