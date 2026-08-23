package system;

import system.windowing.Windowing;

class Layers {
    public static var background = new Layer();
    public static var foreground = new Layer();

    @:noCompletion
    public static function draw():Void {
        background.draw();
        Windowing.draw(); // lazyy
        foreground.draw();
    }

    @:noCompletion
    public static function update(elapsed:Float):Void {
        background.update(elapsed);
        Windowing.update(elapsed);
        foreground.update(elapsed);
    }
}