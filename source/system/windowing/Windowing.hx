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
	static var windows:Array<Window> = new Array();
	static public var active:Window = null;

	public static function add(window:Window) {
		windows.push(window);
	}

	public static function draw() {
		for (window in windows) {
			window.draw();
		}
	}

	static var clickedWindow:Window = null;

	public static function update(elapsed:Float) {
		clickedWindow = null;

		if (FlxG.mouse.justPressed && active == null)
			clickedWindow = topmostWindow();
    
		for (window in windows)
			window.update(elapsed);
	}

	public static function focus(window:Window):Void {
		if (windows.remove(window))
			windows.push(window);
	}

	/// helper functions
	public static function isClickTarget(window:Window):Bool {
		return window == clickedWindow;
	}

	public static function isFocused(w:Window):Bool {
		return windows.length > 0 && windows[windows.length - 1] == w;
	}
	public static function isCoveredByWindow(obj:UIObject):Bool {
		final top = topmostWindow();
		if (top == null)
			return false;
		return !top.owns(obj);
	}

	// under mouse
	public static function topmostWindow():Window {
		var i = windows.length - 1;
		while (i >= 0) {
			if (windows[i].containsMouse())
				return windows[i];
			i--;
		}
		return null;
	}
}
