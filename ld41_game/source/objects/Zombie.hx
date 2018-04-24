package objects;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxPoint;
import flixel.animation.FlxAnimation;
import flixel.animation.FlxAnimationController;

import flixel.system.FlxSound;

import Random;

class Zombie extends FlxSprite {

    public var remHealth:Int;
    public var speed:Float = 10;

    public var type:Int;

    private var moan:FlxSound;
    private var moanTime:Int = Random.int(60,500);

    public function new(?type:Int=1, ?X:Float=0, ?Y:Float=0) {
        super(X, Y);

        this.type = type;
        
        switch(type) {
            case 1:
                loadGraphic(AssetPaths.Zombie_1__png, true, 16, 16);
                moan = FlxG.sound.load(AssetPaths.ld41_zombie1__ogg);
            case 2:
                loadGraphic(AssetPaths.Zombie_2__png, true, 16, 16);
                moan = FlxG.sound.load(AssetPaths.ld41_zombie2__ogg);
            case 3:
                loadGraphic(AssetPaths.Zombie_3__png, true, 16, 16);
                moan = FlxG.sound.load(AssetPaths.ld41_zombie3__ogg);
            default: 
                loadGraphic(AssetPaths.Zombie_1__png, true, 16, 16);
                moan = FlxG.sound.load(AssetPaths.ld41_zombie1__ogg);
        }
             
        animation.add("idle", [0], 1, true);
        animation.add("walk", [0, 1, 2, 3], 4, true);
    
    }

    override public function update(elapsed:Float):Void {
        movement();

        if(--moanTime <= 0) {
            moan.play();
            moanTime = Random.int(400,800);
        }
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