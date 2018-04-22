package utils;

import flixel.FlxState;
import objects.Zombie;
import objects.Zombie1;
import objects.Zombie2;

typedef Lane = { x:Int, y:Int };

class ZombieGenerator {

    private var mainState:FlxState;

    private var lanes = [];
    private var lane1:Lane = { x:100, y:100 };
    private var lane2:Lane = { x:130, y:100 };
    private var lane3:Lane = { x:160, y:100 };
    private var lane4:Lane = { x:190, y:100 };
    private var lane5:Lane = { x:220, y:100 };
    private var lane6:Lane = { x:250, y:100 };

    public function new():Void {
        lanes.push(lane1); // First lane
        lanes.push(lane2); // Second lane
        lanes.push(lane3); // Third lane
        lanes.push(lane4); // Fourth lane
        lanes.push(lane5); // Fifth lane
        lanes.push(lane6); // Sixth lane
    }

    public function create(?zombieType:Int=1, ?lane:Int=0):Zombie {
        var zombie:Zombie;
        switch(zombieType) {
            case 1:
                zombie = new Zombie1(lanes[lane].x, lanes[lane].y);
            case 2:
                zombie = new Zombie2(lanes[lane].x, lanes[lane].y);
            default:
                zombie = new Zombie1(0,0);
        }
        return zombie;
    }
}