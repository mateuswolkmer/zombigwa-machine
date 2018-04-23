package utils;

import objects.*;
import flixel.group.FlxGroup;

class FormationParser {
    public static var firstFormation:String = 
        "300003" +
        "010000" +
        "001030" +
        "000200" +
        "000002" +
        "000200" +
        "000000" +
        "000000";

    private static var formationHeight:Int = 8;
    private static var formationWidth:Int = 6;

    private static var tileSize:Int = 16;
    private static var firstLaneXCoord:Int = 12;

    public function new() {}

    public static function parseStringAndGetZombies(formationString:String):FlxGroup {
        var retval:FlxGroup = new FlxGroup();
        for(y in 0...formationHeight) 
            for(x in 0...formationWidth)
                if(formationString.charAt(y*formationWidth + x) != "0") 
                    retval.add(createZombie(formationString.charAt(y*formationWidth + x), x, y));

        return retval;
    }

    private static function createZombie(zombieType:String, xPos:Int, yPos:Int):Zombie {
        yPos = (formationHeight - yPos - 1) * tileSize * -1;
        xPos = (xPos + firstLaneXCoord) * tileSize;

        return new Zombie(Std.parseInt(zombieType), xPos, yPos);
    }
}