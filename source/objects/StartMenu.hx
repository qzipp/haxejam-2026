package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSignal;
import objects.ui.UIButton;
import objects.ui.UIObject;

using Std;

@:structInit @:publicFields
final class StartMenuItem { // ngl i was under the impression @:structInit made it's variables public
	var label:String;
	var callback:Void->Void;
}

enum abstract StartMenuChangeEvent(Int) to Int from Int {
	var OPEN = 0x01;
	var CLOSE = 0x00;
}

// would make this look betta but we're running out of time QwQ
class StartMenu extends UIObject {
	static inline final ITEM_HEIGHT:Float = 16;
	static inline final MENU_WIDTH:Float = 100;

	var buttons:Array<UIButton> = [];

	public function new(items:Array<StartMenuItem>) {
		super();

		makeGraphic(1, 1, Taskbar.TASKBAR_BACKGROUND_COLOR); // doesn't have an actual hitbox, so be careful
		setGraphicSize(MENU_WIDTH.int(), (ITEM_HEIGHT * items.length).int());
		updateHitbox();

		for (i => item in items) {
			var btn = new UIButton();
			btn.setGraphicSize(MENU_WIDTH.int(), ITEM_HEIGHT.int());
			btn.updateHitbox();
			btn.y = ITEM_HEIGHT * i;
			btn.text.text = item.label;
			btn.text.offset.set(-4, 0);

			btn.pressedCallback.add((?_) -> {
				item.callback();
				close();
			});

			add(btn);
			buttons.push(btn);
		}
	}

	// meooow
	public override function setPosition(x = 0.0, y = 0.0):Void {
		final actual_y = y - (ITEM_HEIGHT * buttons.length);

		this.x = x;
		this.y = actual_y;

		for (i => btn in buttons) {
			btn.x = x;
			btn.y = actual_y + (ITEM_HEIGHT * i);
		}
	}

	/////////////////////////////////

	public function open():Void {
		active = visible = true;
		onChange.dispatch(OPEN);
	}

	public function close():Void {
		active = visible = false;
		onChange.dispatch(CLOSE);
	}

	public var onChange(default, null) = new FlxTypedSignal<StartMenuChangeEvent->Void>();

	/////////////////////////////////

	@:noCompletion
	override function destroy():Void {
		onChange?.destroy();
		super.destroy();
	}
}
