package huds;

import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.group.FlxGroup;

import objects.Head;

class HeadSequence extends FlxObject {
    public var allHeads:FlxGroup = new FlxGroup();

    public var openHeads:Array<Head> = [];
    private var doneHeads:Array<Head> = [];

    public var wrongHead:Bool = false;

    private static inline var brainMachineY:Int = 88;

    public function new(sequence:Array<Int>) {
        super();
        initHeads(sequence);
    }

    private function initHeads(sequence:Array<Int>):Void {
        for(i in 0...sequence.length) {
            var head:Head = new Head(2, 0, new FlxPoint(1,1), sequence[i], false);
            openHeads.push(head);
            allHeads.add(head);
        }
    }

    public function checkInput(head:Head):Bool {
        var retval:Bool = false;
        var currentHead:Head = openHeads.pop();
        if(currentHead.type == head.type) {
            retval = true;
            currentHead.setInactive();
            doneHeads.push(currentHead);
        } else {
            openHeads.push(currentHead);
            wrongHead = true;
        }
        return retval;
    }

    override function update(elapsed:Float):Void
    {
        for(i in 0...openHeads.length) {
            openHeads[i].y = brainMachineY - ((openHeads.length - i - 1) * 16);
        }
        for(i in 0...doneHeads.length) {
            doneHeads[i].y = brainMachineY + ((doneHeads.length - i) * 16);
        }
        super.update(elapsed);
    }
}