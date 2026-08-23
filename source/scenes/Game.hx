package scenes;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFilterFrames;
import flixel.text.FlxText;
import objects.Taskbar;
import objects.ui.UIState;
import openfl.filters.ColorMatrixFilter;
import system.Layers;
import system.State;
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
		var music = FlxG.sound.create(AssetPaths.Fluffing_a_Duck__ogg);
		music.volume = 0.34;
		music.looped = true;
		music.play();

    FileSystem.init();
		State.DELETED_CORE_SIGNAL.add(() -> {
			// switch state to bluescren, play tada too
			State.SCORE += 50;
			music.stop();
			FlxG.switchState(Bluescreen.new);
		});

    Layers.background.add(createWallpaper());
		Layers.background.add({
			var todo = new FlxText(20, 20);
			todo.text = "u must destroy computer";
			todo.size = 12;
			todo;
		});
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
