package objects;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxPoint;
import flixel.animation.FlxAnimation;
import flixel.animation.FlxAnimationController;

class Zombie extends FlxSprite {

    public var remHealth:Int;
    public var speed:Float = 10;

    public function new(?type:Int=1, ?X:Float=0, ?Y:Float=0) {
        super(X, Y);
        switch(type) {
            case 1:
                loadGraphic(AssetPaths.Zombie_1__png, true, 16, 16);
            case 2:
                loadGraphic(AssetPaths.Zombie_2__png, true, 16, 16);
            default: 
                loadGraphic(AssetPaths.Zombie_1__png, true, 16, 16);
        }
             
        animation.add("idle", [0], 1, true);
        animation.add("walk", [0, 1, 2, 3], 10, true);
    
    }

    override public function update(elapsed:Float):Void {
        movement();
        super.update(elapsed);
    }

    public function movement():Void { 
        var velAngle:Float = 90;

        velocity.set(speed, 0);
        velocity.rotate(FlxPoint.weak(0, 0), velAngle);

        if (velocity.x == 0 && velocity.y == 0)
            animation.play("idle");
        else if (touching == FlxObject.NONE) 
            animation.play("walk");  
        
    }
}