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
    FileSystem.init();

    Layers.background.add(createWallpaper());
    Layers.foreground.add(taskbar = new Taskbar());
    // Windowing.add(new Window());
  }

  private function createWallpaper(): FlxSprite {
    final wallpaper = new FlxSprite().loadGraphic(AssetPaths.wallpaper__png);
    wallpaper.setGraphicSize(FlxG.width, FlxG.height);
    wallpaper.updateHitbox();

    final color_matrix = new ColorMatrixFilter([0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 1, 0]);
    Utilities.setSpriteFilters(wallpaper, [color_matrix]);

    return wallpaper;
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
