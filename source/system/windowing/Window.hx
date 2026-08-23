package system.windowing;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxSliceSprite;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteContainer;
import flixel.input.mouse.FlxMouseEvent;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import objects.ui.UIObject;
import openfl.geom.Rectangle;

using Std;

class Window extends FlxSpriteContainer {
	var title:FlxText;

	var window_frame:FlxUI9SliceSprite;
	var window_content_rect:FlxRect;

	var window_background:FlxSprite;

	var body:FlxSpriteContainer;

	public function new() {
		super();

		title = new FlxText();
		title.text = "untitled";
		title.x = 4;
		title.y = 1;

		// makeGraphic(1, 1, 0x00FFFFFF);

		var width = 200;
		var height = 150;
		setSize(width, height);
		window_content_rect = new FlxRect(2, 14, width - (2 + 2), height - (14 + 2));

		body = new FlxSpriteContainer();
		body.x = window_content_rect.left;
		body.y = window_content_rect.top;
		body.clipRect = new FlxRect(0, 0, width, height);

		window_background = new FlxSprite();
		window_background.makeGraphic(window_content_rect.width.int(), window_content_rect.height.int(), 0xFFFFFFFF);

		// window_background.x = window_content_rect.left;
		// window_background.y = window_content_rect.top;

		body.add(window_background);

		add(body);

		// trace(width, height);
		window_frame = new FlxUI9SliceSprite(0, 0, AssetPaths.window__png, new Rectangle(0, 0, width, height), [5, 14, 65, 16], FlxUI9SliceSprite.TILE_BOTH);

		add(window_frame);
		add(title);
		// window_frame.setSize(width, height);

		// titlebar = new FlxSprite();
		// titlebar.makeGraphic(width.int(), 12, 0xFF6F6FE6);
		// titlebar.setGraphicSize(width, 16);
		// updateHitbox();
	}

	override function draw() {
		super.draw();

		// window_background.x = x + window_content_rect.left;
		// window_background.y = y + window_content_rect.top;
		// window_background.draw();

		// for(member in members) {
		// if it were love2d i would not be doing this :sob:
		// if(member is FlxSprite) {
		// var member: FlxSprite = cast member;

		// @:privateAccess member.x += window_content_rect.left;
		// @:privateAccess member.x += window_content_rect.top;
		// member.clipToViewRect = -(x + window_content_rect.left);
		// member..y = -(y + window_content_rect.top);
		// var old_x = member.x;
		// var old_y = member.y;

		// member.x = member.x + x + window_content_rect.left;
		// member.y = member.y + y + window_content_rect.top;

		// Flx
		// member.position
		// member.draw();
		// }
		// }

		// window_frame.x = x;
		// window_frame.y = y;
		// window_frame.draw();

		// title.x = x + 5;
		// title.y = y + 1;
		// title.draw();
	}

	// override function move() {
	// }
	// checks if the mouse is currently within the window's bounds ^w^
	public function containsMouse():Bool {
		if (isMinimized)
			return false;
		final mx = FlxG.mouse.gameX, my = FlxG.mouse.gameY;
		return (mx >= x) && (mx < (x + width)) && (my >= y) && (my < (y + height));
	}

	var moving = false;
	// distance (relative)
	var dx:Float = 0;
	var dy:Float = 0;

	override function update(elapsed:Float) {
		super.update(elapsed);

		move();
	}

	function move() {
		var mx = FlxG.mouse.gameX;
		var my = FlxG.mouse.gameY;

		if (mx < 0)
			mx = 0;
		if (my < 0)
			my = 0;
		if (mx > FlxG.width)
			mx = FlxG.width;
		if (my > FlxG.height)
			my = FlxG.height;

		if (FlxG.mouse.justReleased) {
			Windowing.active = null;
			moving = false;
		}

		if (Windowing.isClickTarget(this)) {
			Windowing.focus(this);

			var on_titlebar = mx >= x && mx < (x + width) && my >= y && my < (y + 12);

			if (on_titlebar) {
				dx = x - mx;
				dy = y - my;

				Windowing.active = this;
				moving = true;
			}
		}

		if (moving) {
			x = FlxMath.bound(mx + dx, 0, FlxG.width - width);
			y = FlxMath.bound(my + dy, 0, FlxG.height - height);
		}
	}

	/////////////////
	public var isMinimized(default, null):Bool = false;

	public function minimize():Void {
		if (isMinimized)
			return;
		isMinimized = true;
		visible = false;
		active = false; // shouldn't update when hidden
	}

	public function restore():Void {
		if (!isMinimized)
			return;
		isMinimized = false;
		visible = true;
		active = true;
	}
	public function owns(obj:UIObject, ?members:Array<FlxBasic> = null):Bool {
		return body.members.indexOf(cast obj) != -1;
	}
}
