package scenes;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFilterFrames;
import objects.Taskbar;
import objects.ui.UIState;
import openfl.filters.ColorMatrixFilter;
import system.Layers;
import system.Toasts;
import system.applications.Explorator;
import system.filesystem.FileSystem;
import system.windowing.Window;
import system.windowing.Windowing;

using Std;

class Game extends UIState {
  public static var taskbar(default, null): Taskbar;

  @:noCompletion
  override public function create() {
    var wallpaper = new FlxSprite();
    wallpaper.loadGraphic(AssetPaths.wallpaper__png);
    wallpaper.setGraphicSize(FlxG.width, FlxG.height);
    wallpaper.updateHitbox();

    wallpaper.frames = FlxFilterFrames.fromFrames(wallpaper.frames, [
      // uh
      new ColorMatrixFilter([0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 1, 0])
    ]);

    Layers.background.add(wallpaper);

    FileSystem.init();
    Layers.foreground.add(taskbar = new Taskbar());
    // Windowing.add(new Window());
  }

  @:noCompletion
  override public function draw() {
    Layers.draw();
    Toasts.draw();
  }

  @:noCompletion
  override public function update(elapsed: Float) {
    super.update(elapsed);
    Layers.update(elapsed);
    Toasts.update(elapsed);
  }
}
