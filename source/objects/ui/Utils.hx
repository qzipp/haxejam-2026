package objects.ui;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxAxes;

class Utils
{
	public static inline function centerOnObject<T:FlxObject>(spr:T, target:FlxObject, axes:FlxAxes = XY):T
	{
		if (axes.x)
			spr.x = target.x + (target.width - spr.width) / 2;
		if (axes.y)
			spr.y = target.y + (target.height - spr.height) / 2;

		return spr;
	}

	@:noCompletion static var __mousePoint:FlxPoint = new FlxPoint();
	@:noCompletion static var __objPoint:FlxPoint = new FlxPoint();

	public static function mouseOverlapping<T:FlxObject>(obj:T, ?mousePoint:FlxPoint, ?camera:FlxCamera)
	{
		camera ??= obj.camera;
		mousePoint ??= FlxG.mouse.getViewPosition(camera, __mousePoint);
		obj.getScreenPosition(__objPoint, camera);
		return FlxMath.pointInCoordinates(mousePoint.x, mousePoint.y, __objPoint.x, __objPoint.y, obj.width, obj.height);
	}
}
