package objects;

import flixel.FlxSprite;

class BrainMachine extends FlxSprite {
    public function new() {
        super(16, 64);
        // Loads graphics
        loadGraphic(AssetPaths.Brain_Machine__png, true, 32, 64);
    }
}