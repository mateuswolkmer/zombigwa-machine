package objects;

import flixel.FlxSprite;
import objects.Head;
import huds.HeadSequence;

class BrainMachine extends FlxSprite {

    private var headSequence:HeadSequence;
    private var animPlayFrames:Int = 0;

    public function new(headSeq:HeadSequence) {
        super(16, 64);

        this.headSequence = headSeq;

        // Loads graphics
        loadGraphic(AssetPaths.Brain_Machine__png, true, 32, 64);

        animation.add("idle", [0], 1, true);
        animation.add("gotBrain", [0,1,2], 20, true);

        setSize(16, 64);
    }

    public function headHitCheck(head:Head):Void {
        if(headSequence.checkInput(head)) trace("Right head");
        else trace("Wrong head");

        animation.play("gotBrain");
        animPlayFrames = 60;
    }

    override public function update(elapsed:Float):Void {
        
        if(animPlayFrames == 0) animation.play("idle");
        else animPlayFrames--;

        super.update(elapsed);
    }
}