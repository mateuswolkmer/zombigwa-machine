package objects;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.animation.FlxAnimation;
import flixel.animation.FlxAnimationController;

class Zombie2 extends Zombie {

    public function new(?X:Float=0, ?Y:Float=0) {
        super(X, Y);
        // Loads graphics
        loadGraphic(AssetPaths.Zombie_2__png, true, 16, 16);
        scale.set(3, 3);
        // Set up animation        
        animation.add("idle", [0], 1, true);
        animation.add("walk", [0, 1, 2, 3], 10, true);

        maxHealth = 300;
        remHealth = 300;
        speed = 250;
    }
}