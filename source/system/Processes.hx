package system;

import haxe.ds.IntMap;
import objects.Taskbar;
import system.windowing.Window;
import system.windowing.Windowing;

enum abstract ProcessId(Int) from Int to Int {
	var Explorer = 0x00;
	var InternetExplorer = 0x01;
	// var Radio = "radio";
}

final class Processes {
	static var processes:Map<ProcessId, Window> = new IntMap(); // basically a intmap LOL

	public static function launch(id:ProcessId, window:Window):Window {
		final existing = processes.get(id);
		if (existing != null) { // 🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛🐈‍⬛
			Windowing.focus(existing);
			return existing;
		}

		processes.set(id, window);
		Windowing.add(window);
		@:privateAccess
		Taskbar.addProcess(window, window.title.text);
		return window;
	}

	public static function unregister(id:ProcessId):Void {
		final window = processes.get(id);
		if (window == null)
			return;
		processes.remove(id);
		Taskbar.removeProcess(window);
	}
}
