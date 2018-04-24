package objects;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Head extends FlxSprite {
    public var dir:FlxPoint;
    private var speed:Float = 300;
    public var type:Int;
    private var moving:Bool;

    public function new(X:Float, Y:Float, DIR:FlxPoint, type:Int, ?moving:Bool = true) {
        super(X, Y);

        this.type = type;
        this.moving = moving;
        
        loadGraphic(AssetPaths.Heads__png, true, 12, 12);

        switch(type) {
            case 1:
                animation.add("idle", [0], 1, true);
            case 2:
                animation.add("idle", [1], 1, true);
            case 3:
                animation.add("idle", [2], 1, true);
            default: 
                animation.add("idle", [0], 1, true);
        }
        animation.play("idle");
        
        this.setPosition(X, Y);
        drag.x = drag.y = 1800;

        this.dir = new FlxPoint(DIR.x, DIR.y);
        dir.scale(speed / getVectorLength(dir));

        if(moving) {
            setSize(7, 12);
            offset.set(3, 0);
        }
    }

    private function getVectorLength(vector:FlxPoint):Float
    {
        var length:Float = Math.sqrt(vector.x * vector.x + vector.y * vector.y);
        return length;
    }

    override public function update(elapsed:Float):Void
    {
        if(moving) velocity.set(dir.x, dir.y);
        super.update(elapsed);
    }

    public function setInactive():Void {
        this.color = 0x555555;
    }

}