package system;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxSliceSprite;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import objects.ui.UIObject;
import openfl.geom.Rectangle;

using Std;

class Window extends UIObject {
  var title: FlxText;
  
  var window_frame: FlxUI9SliceSprite;

  public function new() {
    super();
    
    title = new FlxText();
    title.text = "untitled";

    makeGraphic(1, 1, 0x00FFFFFF);

    width = 200;
    height = 150;

    setGraphicSize(width, height);
    updateHitbox();
    
    window_frame = new FlxUI9SliceSprite(0, 0, AssetPaths.window__png, new Rectangle(0, 0, width, height), [5, 14, 65, 16], FlxUI9SliceSprite.TILE_BOTH);
    // window_frame.setSize(width, height);
    
    // titlebar = new FlxSprite();
    // titlebar.makeGraphic(width.int(), 12, 0xFF6F6FE6);
    // titlebar.setGraphicSize(width, 16);
    updateHitbox();
  }

  override function draw() {
    // super.draw();

    for(member in members) {
      // if it were love2d i would not be doing this :sob:
      if(member is FlxSprite){
        var member: FlxSprite = cast member;

        member.offset.x = -(x + 2);
        member.offset.y = -(y + 14);
        member.draw();
      }
    }

    window_frame.x = x;
    window_frame.y = y;
    window_frame.draw();

    title.x = x + 5;
    title.y = y + 1;
    title.draw();
  }

  // override function move() {
    
  // }

  var moving = false;
  // distance (relative)
  var dx: Float = 0; 
  var dy: Float = 0;

  override function update(elapsed: Float) {
    super.update(elapsed);

    var mx = FlxG.mouse.gameX;
    var my = FlxG.mouse.gameY;
    
    if(mx < 0) mx = 0;
    if(my < 0) my = 0;
    if(mx > FlxG.width) mx = FlxG.width;
    if(my > FlxG.height) my = FlxG.height;
  
    if(FlxG.mouse.justReleased)
      moving = false; 

    if(FlxG.mouse.justPressed) {
      var on_titlebar = 
        mx >= x && mx < (x + width) &&
        my >= y && my < (y + 12);

      if(on_titlebar) {
        dx = x - mx;
        dy = y - my;

        moving = true;
      }
    }

    if(moving) {
      x = mx + dx;    
      y = my + dy; 
    }
  }
}

class Windowing {
  static var windows: Array<Window> = new Array();

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
}