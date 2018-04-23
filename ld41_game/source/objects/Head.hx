package objects;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Head extends FlxSprite {
    private var dir:FlxPoint;
    private var speed:Float = 300;

    public function new(X:Float, Y:Float, DIR:FlxPoint) {
        super(X, Y);
        makeGraphic(8, 8, FlxColor.BLUE);
        
        this.setPosition(X, Y);
        drag.x = drag.y = 1800;

        this.dir = new FlxPoint(DIR.x, DIR.y);
        dir.scale(speed / getVectorLength(dir));
    }

    private function getVectorLength(vector:FlxPoint):Float
    {
        var length:Float = Math.sqrt(vector.x * vector.x + vector.y * vector.y);
        return length;
    }

    override public function update(elapsed:Float):Void
    {
        velocity.set(dir.x, dir.y);
        super.update(elapsed);
    }

}