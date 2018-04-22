package objects;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxPoint;
import flixel.animation.FlxAnimation;
import flixel.animation.FlxAnimationController;

class Zombie1 extends Zombie {

    public function new(?X:Float=0, ?Y:Float=0) {
        super(X, Y);
        // Loads graphics
        loadGraphic(AssetPaths.Zombie_1__png, true, 16, 16);
        // scale.set(3, 3);
        // Set up animation        
        animation.add("idle", [0], 1, true);
        animation.add("walk", [0, 1, 2, 3], 10, true);
        
        maxHealth = 50;
        remHealth= 50;
        speed = 50;
    }
}