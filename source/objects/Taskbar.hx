package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import objects.ui.UIButton;
import objects.ui.UIObject;
import scenes.Game;
import system.Processes;
import system.applications.Explorator;
import system.windowing.Window;
import system.windowing.Windowing;

class Taskbar extends UIObject {
	public static inline final TASKBAR_BACKGROUND_COLOR:FlxColor = 0xFF19191D;

	var bg:FlxSprite;

	var start_menu:StartMenu;
	var start_menu_open = false;

	var start_button:UIButton;

	public function new() {
		super();

		// setGraphicSize(1, 1);
		makeGraphic(1, 1, 0x00FFFFFF);
		y = FlxG.height - 16;

		bg = new FlxSprite(0, y).makeGraphic(1, 1, TASKBAR_BACKGROUND_COLOR);
		bg.setGraphicSize(FlxG.width, 16);
		bg.updateHitbox();
		add(bg);

		start_button = create_start_button();
		start_menu = create_start_menu();

		start_button.pressedCallback.add((?_) -> {
			if (start_menu_open)
				start_menu.close();
			else
				start_menu.open();
		});
	}

	function create_start_button():UIButton {
		var start_button = new UIButton();
		start_button.y = y;
		start_button.setGraphicSize(48, 16);
		start_button.updateHitbox();

		var logo = new FlxSprite();
		logo.loadGraphic(AssetPaths.haxe__png);
		logo.setGraphicSize(12, 12);
		logo.x = start_button.x;
		logo.y = start_button.y;
		start_button.add(logo);

		start_button.text.text = "start";
		start_button.text.offset.set(-7, 0);
		add(start_button);
		return start_button;
	}

	/**
	 * creates the start menu duh
	 * i fw with this (kinda)
	 * it could be better but it'll do for now
	 * we unfortunately do not have much time
	 */
	function create_start_menu():StartMenu {
		final menu = new StartMenu([
			{
				label: "Explorer",
				callback: () -> Processes.launch(Explorer, new Explorator())
			},
			{label: "Internet Explorer", callback: () -> Processes.launch(InternetExplorer, new Explorator())},
			{label: "Radio", callback: () -> trace("open radio")},
			{label: "Shutdown", callback: () -> trace("shutdown")}
		]);
		menu.onChange.add((t) -> {
			start_menu_open = (t == OPEN);
		});
		add(menu);
		menu.setPosition(start_button.x, start_button.y);
		menu.close();
		return menu;
	}

	var process_buttons = new Map<Window, UIButton>();

	static inline final PROCESS_BUTTON_WIDTH:Float = 64;
	static inline final PROCESS_BUTTON_START_X:Float = 48;

	function create_process_button(window:Window, label:String):UIButton {
		final btn = new UIButton();
		btn.y = y;
		btn.setGraphicSize(PROCESS_BUTTON_WIDTH, 16);
		btn.updateHitbox();
		btn.text.text = label;

		btn.pressedCallback.add((?_) -> { // todo: maximize?
			if (window.isMinimized) {
				window.restore();
				Windowing.focus(window);
			} else if (Windowing.isFocused(window)) {
				window.minimize();
			} else {
				Windowing.focus(window);
			}
		});

		add(btn);
		process_buttons.set(window, btn);
		reorganize_process_btns();
		return btn;
	}

	function destroy_process_button(window:Window):Void {
		final btn = process_buttons.get(window);
		if (btn == null)
			return;
		remove(btn);
		btn.destroy();
		process_buttons.remove(window);
		reorganize_process_btns();
	}

	function reorganize_process_btns():Void {
		var i = 0;
		for (btn in process_buttons)
			btn.x = PROCESS_BUTTON_START_X + (i++) * PROCESS_BUTTON_WIDTH;
	}

	public static function addProcess(window:Window, label:String):Void {
		if (Game.taskbar == null)
			return; // make taskbar instance var thingy thing?
		Game.taskbar.create_process_button(window, label);
	}

	public static function removeProcess(window:Window):Void {
		if (Game.taskbar == null)
			return;
		Game.taskbar.destroy_process_button(window);
	}
}
