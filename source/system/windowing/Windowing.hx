package system.windowing;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxSliceSprite;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.util.FlxSignal.FlxTypedSignal;
import objects.ui.UIObject;
import openfl.geom.Rectangle;

using Std;

class Windowing {
  static var windows: Array<Window> = new Array();
  static public var active: Window = null;

  public static function add(window: Window) {
    windows.push(window);
  }

  public static function draw() {
    for(window in windows) {
      window.draw();
    }
  }

  public static function update(elapsed: Float) {
    
    for(window in windows)
      window.update(elapsed);
  }

  // to be used and implemented properly, i wanna solve the isue of windows being able to pass-through mouse interactions 
  // (like with buttons) lol
  public static var onMouseDown = new FlxTypedSignal<Void->Void>();
  public static var onMouseUp = new FlxTypedSignal<Void->Void>();
  public static var onMouseMove = new FlxTypedSignal<Void->Void>();
}