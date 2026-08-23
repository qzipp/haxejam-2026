package objects.ui;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxState;
import impl.IUIFocusable;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;

class UIState extends FlxState
{
	@:isVar
	public static var state(get, never):UIState;

	static function get_state():UIState
		return FlxG.state is UIState ? cast FlxG.state : null;

	public var currentFocus:IUIFocusable = null;

	public var focus(get, never):FlxBasic;

	function get_focus():FlxBasic
		return __focus;

	@:noCompletion var __focus:FlxBasic = null;

	public var hoveredSprite:UIObject = null;
	public var currentCursor:MouseCursor = ARROW;

	override public function update(elapsed:Float):Void
	{
		@:privateAccess
		UIObject.__findTopmost();
		super.update(elapsed);

		if (FlxG.mouse.justReleased)
			currentFocus = (hoveredSprite is IUIFocusable) ? (cast hoveredSprite) : null;

		final cursor = hoveredSprite != null ? hoveredSprite.cursor : currentCursor;
		if (cursor != Mouse.cursor) Mouse.cursor = cursor;

		hoveredSprite = null;
	}

	override function destroy():Void
	{
		Mouse.cursor = ARROW;
		super.destroy();
	}
}