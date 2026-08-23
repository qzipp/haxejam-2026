package objects.ui;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxSignal.FlxTypedSignal;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;
import system.windowing.Windowing;

class UIObject extends FlxSprite
{
	static var tracked_objs:Array<UIObject> = [];

	// topmost ui obj (under mouse LOL)
	static var topmost:UIObject = null;

	static function __findTopmost():Void {
		topmost = null;

		for (i in 0...tracked_objs.length) {
			final obj = tracked_objs[tracked_objs.length - 1 - i];
			if (obj.exists && obj.active && obj.visible && obj.__detectOverlaps && Utils.mouseOverlapping(obj) && !Windowing.isCoveredByWindow(obj)) {
				topmost = obj;
				break;
			}
		}
	}

	public var focused:Bool = false;

	public var members:Array<FlxBasic> = [];

	function add(v:FlxBasic):Void members.push(v);
	function remove(v:FlxBasic, splice:Bool = true):FlxBasic {
		if (splice)
			members.remove(v);
		else {
			final i = members.indexOf(v);
			if (i != -1) members[i]= null;
		}
		return v;
	}

	function __drawMembers():Void {
		for (i in members) if (i!=null && i.active && i.visible && i.draw != null) i.draw();
	}
	function __updateMembers(elapsed:Float):Void {
		for (i in members) if(i!=null)i.update(elapsed);
	}

	override function draw()
	{
		super.draw();
		this.__drawMembers();
	}

	/**
	 * Whether you should automatically change the mouse on focus.
	 */
	public var changeMouseOnFocus:Bool = true;

	public var available:Bool = true;

	@:noCompletion override function destroy():Void
	{
		tracked_objs.remove(this);
		members = FlxDestroyUtil.destroyArray(members);
		pressedCallback?.destroy();
		focusChange?.destroy();
		super.destroy();
	}

	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:flixel.system.FlxAssets.FlxGraphicAsset):Void
	{
		super(X, Y, SimpleGraphic);
		focusChange.add((c, ?u) -> if (available && changeMouseOnFocus) u.cursor = c ? BUTTON : HAND);
		tracked_objs.push(this);
	}

	public var pressedCallback:FlxTypedSignal<?UIObject->Void> = new FlxTypedSignal();

	public var focusChange:FlxTypedSignal<(Bool, ?UIObject) -> Void> = new FlxTypedSignal();
	public var cursor:MouseCursor = ARROW;

	@:noCompletion var __previousFocus:Bool = false;
	var __detectOverlaps:Bool = true;

	@:dox(hide) override public function update(elapsed:Float):Void
	{
		if (!active)
			return; // skip everything while inactive
		super.update(elapsed);

		this.__updateMembers(elapsed);
		__previousFocus = focused;
		focused = false;
		if (__detectOverlaps && topmost == this)
		{
			focused = true;
			if (FlxG.mouse.justPressed)
				if (pressedCallback != null && available)
					pressedCallback.dispatch(this);
		}

		if (focusChange != null && available)
		{
			if (focused && UIState.state != null)
				UIState.state.hoveredSprite = (focused ? this : null);
			if (__previousFocus != focused)
				focusChange.dispatch(focused, this);
		}
	}
}