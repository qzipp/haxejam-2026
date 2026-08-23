package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxFilterFrames;
import openfl.filters.BitmapFilter;
import openfl.filters.ColorMatrixFilter;

final class Utilities {
  public static function setSpriteFilters<T: FlxSprite>(sprite: T, filters: Array<BitmapFilter>): T {
    sprite.frames = FlxFilterFrames.fromFrames(sprite.frames, filters); // shhhhhhh
    return sprite;
  }
}
