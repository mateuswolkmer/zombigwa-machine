// package objects;

// import flixel.FlxSprite;
// import flixel.FlxState;

// class ZombieGenerator extends FlxSprite {

//     private var mainState:FlxState;

//     // typedef Lane = { x:Int, y:Int };
//     private var lanes:List;

//     public function new(?state:FlxState) {
//         mainState = state;
//         list.add(Lane = { x:100, y:100}); // First lane
//         list.add(Lane = { x:130, y:100}); // Second lane
//         list.add(Lane = { x:160, y:100}); // Third lane
//         list.add(Lane = { x:190, y:100}); // Fourth lane
//         list.add(Lane = { x:220, y:100}); // Fifth lane
//         list.add(Lane = { x:250, y:100}); // Sixth lane
//     }

//     public function create(?zombieType:Int=1, ?lane:Int=0):Void {
        
//         switch(zombieType) {
//             case 1:
//                 var zombie:Zombie1 = new Zombie1(lists.get(lane));
//                 mainState.add(zombie);
//             case 2:
//                 var zombie:Zombie2 = new Zombie2(lists.get(lane));
//                 mainState.add(zombie);
//             case 3:
//         }
//     }
// }