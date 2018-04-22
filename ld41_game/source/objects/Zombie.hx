package objects;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxPoint;
import flixel.animation.FlxAnimation;
import flixel.animation.FlxAnimationController;

class Zombie extends FlxSprite {
    // Player maximum health
    public var maxHealth:Int;
    // Player reangleining health
    public var remHealth:Int;
    // Player movement speed
    public var speed:Float;

    public function new(?X:Float=0, ?Y:Float=0) {
        super(X, Y);
        // Randomized first movement
        if(Random.bool()) 
            facing = FlxObject.LEFT;
        else
            facing = FlxObject.RIGHT;
        // Sets drag speed for when the movement stops
        drag.x = drag.y = 1600;
    }

    override public function update(elapsed:Float):Void {
        movement();
        super.update(elapsed);
    }

    public function movement():Void {        
        var up:Bool = false;
        var down:Bool = true;
        var left:Bool = false;
        var right:Bool = false;
        // Doesn't move twice in the same direction
        if (facing != FlxObject.LEFT)
            left = Random.bool();
        else if (facing != FlxObject.RIGHT)
            right = Random.bool();
                
        if (left)
            facing = FlxObject.LEFT;
        else if (right)
            facing = FlxObject.RIGHT;

        if (left)
            facing = FlxObject.LEFT;
        else if (right)
            facing = FlxObject.RIGHT;

        if (up || down || left || right) {
            // Verifies the angle of movement to determine the diagonal speed
            var angle:Float = 0;
            if (up) {
                angle = -90;
                if (left)
                    angle -= 45;
                else if (right)
                    angle += 45;
            }
            else if (down) {
                angle = 90;
                if (left)
                    angle += 45;
                else if (right)
                    angle -= 45;
            }
            else if (left) {
                angle = 180;
            }
            else if (right) {
                angle = 0;
            }
            // Sets speed and rotation
            velocity.set(speed, 0);
            velocity.rotate(FlxPoint.weak(0, 0), angle);      
        }
        // Animates
        if (velocity.x == 0 && velocity.y == 0)
            animation.play("idle");
        else if (touching == FlxObject.NONE) 
            animation.play("walk");  
    }
}