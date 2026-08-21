package system;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

using Math;
using Std;

typedef Toast = {
  message: String,
  expiry: Float
};

class Toasts {
  public static var toasts: Array<Toast> = new Array();
  public static function push(message: String, expiry: Float) {
    toasts.push({
      message: message,
      expiry: Date.now().getTime() + expiry * 1000
    });
  }

  public static function draw() {
    for(i => toast in toasts) {
      //bad? yeh
      var text = new FlxText(FlxG.width - 100, 50 * i, toast.message);
      
      text.draw();
    }
  }

  public static function update(elapsed: Float) {
    for(i => toast in toasts) {
      if(Date.now().getTime() >= toast.expiry) {
        toasts.remove(toast);
      } 
    }
  }
}