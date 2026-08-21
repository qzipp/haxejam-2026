package;

import flixel.FlxGame;
import openfl.display.Sprite;
import scenes.Game;

class Main extends Sprite
{
	public function new()
	{
		super();
    addChild(new FlxGame(320, 240, Game, 60, 60, true, false));
	}
}
