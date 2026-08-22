package scenes;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.input.FlxInput;
import flixel.text.FlxInputText;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import objects.Taskbar;
import objects.ui.UIButton;
import objects.ui.UIState;
import openfl.geom.Rectangle;
import system.Toasts;
import system.Windowing;
import system.filesystem.FileSystem;

using Std;

class Game extends UIState
{
	var messages = new Array<String>();

	override public function create() {
		var taskbar = new Taskbar();

		add(taskbar);

		Windowing.add({
			var window = new Window();
		
			var bg = new FlxSprite();

			bg.makeGraphic(window.width.int() - 4, window.height.int() - 16, 0xFFFFFFFF);

			@:privateAccess window.add(bg);

			window;
		});
    new FileSystem();
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
