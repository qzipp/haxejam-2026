package objects.ui;

import flixel.addons.display.FlxSliceSprite;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.animation.FlxAnimationController;
import flixel.graphics.frames.FlxTileFrames;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil;
import openfl.geom.Rectangle;
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

	public function new(width:Float = 64.0)
	{
		super();

		makeGraphic(1, 1, 0xff212329);

		this.width = width;

    var slice = new FlxUI9SliceSprite(0, 0, AssetPaths.button__png, new Rectangle(0, 0, width, 14 * 3), [6, 6, 9, 10], FlxUI9SliceSprite.TILE_BOTH);
    loadGraphic(slice.graphic);
		frames = FlxTileFrames.fromGraphic(graphic, FlxPoint.get(width, 14));
		// setGraphicSize(width, height);

    updateHitbox();
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

  override function draw() {
    // kill me
    text.centerOnObject(this);
    super.draw();
  }

	override function update(elapsed:Float)
	{
    super.update(elapsed);
	}
}
