package scenes;

import objects.Taskbar;
import objects.ui.UIState;
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
    add(taskbar = new Taskbar());
    // Windowing.add(new Window());
  }

  @:noCompletion
  override public function draw() {
    Toasts.draw();
    Windowing.draw();
    super.draw();
  }

  @:noCompletion
  override public function update(elapsed: Float) {
    super.update(elapsed);
    Toasts.update(elapsed);
    Windowing.update(elapsed);
  }
}
