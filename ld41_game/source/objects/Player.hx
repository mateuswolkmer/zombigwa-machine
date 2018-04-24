package objects;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.animation.FlxAnimation;
import flixel.animation.FlxAnimationController;
import openfl.events.MouseEvent;
import flixel.group.FlxGroup;
import flixel.system.FlxSound;

import objects.Projectile;

class Player extends FlxSprite {
    // Player maximum health
    public var maxHealth:Int = 100;
    // Player reangleining health
    public var remHealth:Int = 100;
    // Player movement speed
    public var speed:Float = 100;
    // Check if a shoot action occurs
    public var isShooting:Bool = false;
    private var shootSound:FlxSound;

    public var projectiles:FlxGroup = new FlxGroup();

    public function new(?X:Float=0, ?Y:Float=0) {
        super(X, Y);
        // Loads graphics
        loadGraphic(AssetPaths.Character_To_Left__png, true, 16, 16);
        shootSound = FlxG.sound.load(AssetPaths.ld41_shot__ogg);

        setSize(15, 1);
        offset.set(-1, 7);

        scale.set(1.5,1.5);
        // Set up the rotation
        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);
        // Set up animation
        var walkingSpeed:Int = Std.int(speed/30.0);
        animation.add("idle", [0], 1, true);
        
        animation.add("walk_up", [0, 1, 2, 3, 4, 5], walkingSpeed, true);
        animation.add("walk_down", [5, 4, 3, 2, 1, 0], walkingSpeed, true);

        animation.add("shoot_straight", [6, 7, 6], 20, false);
        animation.add("shoot_up", [8, 9, 8], 20, false);
        animation.add("shoot_down", [10, 11, 10], 20, false);
        // Sets drag speed for when the movement stops
        drag.x = drag.y = 1600;
    }

    override public function update(elapsed:Float):Void {
        movement();
        shoot();
        super.update(elapsed);
    }

    public function movement():Void {
        // Checks for movement input
        var up:Bool = FlxG.keys.anyPressed([UP, W]);
        var down:Bool = FlxG.keys.anyPressed([DOWN, S]);
        var left:Bool = FlxG.keys.anyPressed([LEFT, A]);
        var right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

        if (up && down)
            up = down = false;
        if (left && right)
            left = right = false;

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
            if(velocity.y < 0) // Going up
                facing = FlxObject.UP;
            else if(velocity.y > 0) // Going down
                facing = FlxObject.DOWN;          
        }
        // Animates
        if(isShooting) {
            // Cheeck for mouse position on click to determine animation
            if(animation.curAnim.name != "shoot_straight" &&
               animation.curAnim.name != "shoot_up" &&
               animation.curAnim.name != "shoot_down") {
                var playerPos:FlxPoint = this.getPosition();
                var mousePos:FlxPoint = FlxG.mouse.getPosition();
                
                if((mousePos.y - playerPos.y) > 50)
                    animation.play("shoot_down");
                else if((mousePos.y - playerPos.y) < -50)
                    animation.play("shoot_up");
                else
                    animation.play("shoot_straight");

                if((mousePos.x - playerPos.x) > 0)
                    facing = FlxObject.RIGHT;
                else
                    facing = FlxObject.LEFT;
            }
            if(animation.finished) {
                stopShoot();
                facing = FlxObject.LEFT;
            }
        }
        else if (velocity.x == 0 && velocity.y == 0)
            animation.play("idle");
        else if (touching == FlxObject.NONE) {
            if (facing == FlxObject.UP)
                animation.play("walk_up");
            else
                animation.play("walk_down");
        }
    }

    public function shoot():Void {
        // Checks for mouse input
        if(FlxG.mouse.justPressed) {
            shootSound.play();
            isShooting = true;
            var throwDir:FlxPoint = FlxG.mouse.getScreenPosition();

            projectiles.add(new Projectile(this.x, this.y + this.height / 2, throwDir.subtract(this.x, this.y + this.height / 2)));
        }
    }
    public function stopShoot():Void {
        isShooting = false;
    }
}