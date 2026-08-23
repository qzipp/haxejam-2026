package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import openfl.display.Sprite;
import scenes.Game;

class Main extends Sprite
{
	public static final VERSION:Array<Int> = [0, 0, 1];

	public function new()
	{
		super();
		addChild(new FlxGame(320, 240, Game, 60, 60, true, false));
		FlxG.scaleMode = new PixelPerfectScaleMode();
	}
}
