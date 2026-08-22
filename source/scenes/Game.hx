package scenes;

import objects.Taskbar;
import objects.ui.UIState;
import system.Toasts;
import system.applications.Explorator;
import system.filesystem.FileSystem;
import system.windowing.Window;
import system.windowing.Windowing;

using Std;

class Game extends UIState
{
	var messages = new Array<String>();

	override public function create() {
		var taskbar = new Taskbar();

		add(taskbar);

    FileSystem.init();
		
    var explorator = new Explorator();
    explorator.x = 50;
    Windowing.add(explorator);
    Windowing.add(new Window());
	}

	override public function draw() {
		super.draw();

		Toasts.draw();
		Windowing.draw();
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		Toasts.update(elapsed);
		Windowing.update(elapsed);
	}
}
