package utils;

import objects.*;
import flixel.group.FlxGroup;

class FormationParser {
    private static var firstFormation:String = 
        "000000" +
        "000000" +
        "001000" +
        "000200" +
        "000100" +
        "000200" +
        "000000" +
        "030000";

    private static var secondFormation:String = 
        "030000" +
        "000000" +
        "001030" +
        "000010" +
        "100002" +
        "000200" +
        "001000" +
        "000000";

    private static var thirdFormation:String = 
        "300003" +
        "010000" +
        "001030" +
        "000200" +
        "000002" +
        "000200" +
        "000000" +
        "000000";

    private static var forthFormation:String = 
        "100101" +
        "031000" +
        "101100" +
        "100010" +
        "010200" +
        "001010" +
        "000010" +
        "000000";

    private static var fifthFormation:String = 
        "030020" +
        "001000" +
        "021200" +
        "000300" +
        "111000" +
        "000100" +
        "200000" +
        "000000";

    private static var firstSequence:Array<Int> = [1];
    private static var secondSequence:Array<Int> = [2,1];
    private static var thirdSequence:Array<Int> = [1,3,2];
    private static var forthSequence:Array<Int> = [3,1,1,2,1];
    private static var fifthSequence:Array<Int> = [3,1,2,1,1,3];

    public static var formations:Array<String> = [firstFormation, secondFormation, thirdFormation, forthFormation, fifthFormation];
    public static var sequences:Array<Array<Int>> = [firstSequence, secondSequence, thirdSequence, forthSequence, fifthSequence];

    private static var formationHeight:Int = 8;
    private static var formationWidth:Int = 6;

    private static var tileSize:Int = 16;
    private static var firstLaneXCoord:Int = 10;

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
        yPos = formationHeight - yPos;
        yPos = ((yPos - 1) * tileSize  + (yPos * 8)) * -1;
        xPos = (xPos + firstLaneXCoord) * tileSize;

        return new Zombie(Std.parseInt(zombieType), xPos, yPos);
    }
}