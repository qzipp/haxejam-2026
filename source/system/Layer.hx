package system;

import flixel.FlxBasic;

class Layer {
    var members:Array<FlxBasic> = [];

    public function new() {}

    public function add(obj:FlxBasic):Void {
        members.push(obj);
    }

    public function remove(obj:FlxBasic):Void {
        members.remove(obj);
    }

    public function draw():Void {
        for (obj in members)
            if (obj.visible)
                obj.draw();
    }

    public function update(elapsed:Float):Void {
        for (obj in members)
            if (obj.active)
                obj.update(elapsed);
    }
}