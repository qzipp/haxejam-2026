package objects.ui;

import flixel.text.FlxText;
import openfl.ui.Mouse;

using Std;
using objects.ui.Utils;

// enum abstract UIButtonStyle(String) to String
// {
// 	final PRIMARY_RECT = 'button-primary-rect';
// 	final PRIMARY_CUBE = 'button-primary-cube';

// 	final SECONDARY_RECT = 'button-secondary-rect';
// 	final SECONDARY_CUBE = 'button-secondary-cube';

// 	final GRAY_RECT = 'button-gray-rect';
// 	final GRAY_CUBE = 'button-gray-cube';
// }

class UIButton extends UIObject
{
	public var text:FlxText;

	public function new()
	{
		super();

		makeGraphic(1, 1, 0xff212329);

		width = 64.0;
		height = 16.0;

		setGraphicSize(width, height);

		// loadGraphic(AssetPaths.button__png, true, 52, 12);
		animation.add("normal", [0], 1, true);
		animation.add("hover", [1], 1, true);
		animation.add("pressed", [2], 1, true);

		pressedCallback.add((?_) ->
		{
			animation.play("pressed");
		});

		focusChange.add((focused, ?_) ->
		{
			if (focused)
			{
				this.cursor = BUTTON;
				animation.play("hover");
			}
			else
			{
				this.cursor = AUTO;
				animation.play("normal");
			}
		});

		this.text = new FlxText("button");
		add(this.text);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		text.centerOnObject(this);
	}
}
