package system.applications;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import objects.ui.UIButton;
import objects.ui.UIObject;
import system.filesystem.FileSystem;
import system.filesystem.NodeType;
import system.filesystem.nodes.Drive;
import system.filesystem.nodes.Folder;
import system.windowing.Window;

using Std;

class Explorator extends Window {
	var current:NodeType = null;

	var path_text:FlxText;

  public function new() {
    super();

		current = null;

    title.text = "Explorator";

    var text = new FlxText(50, 0, " Hi");
    body.add(text);

		var up_button = new UIButton(32);
		up_button.text.text = "back";
		up_button.x = 0;
		up_button.pressedCallback.add((?_) -> {
			if (current == null)
				return;

			current = switch current {
				case File(file) if (file.parent is Folder && file.parent != null):
					Folder(cast file.parent);
				case Folder(folder) if (folder.parent is Folder && folder.parent != null):
					Folder(cast folder.parent);
				case _: null;
			}
			refresh();
		});
		body.add(up_button);

		path_text = new FlxText(38, 0, 70);
		path_text.color = 0x000000;
		path_text.text = "";

		body.add(path_text);

		var refresh_button = new UIButton();
    refresh_button.text.text = "refresh";
		refresh_button.x = width - 68;

    refresh();
		refresh_button.pressedCallback.add((?_) -> {
      refresh();
    });
    body.add(refresh_button);

		// FlxTimer.loop(1.0, (_) -> refresh(), 0);
	}

	var topbar_offset = 20;
	public function make_file(f:NodeType) {
		switch f {
			case File(file):
				var g:Array<FlxSprite> = [];

				var text = new FlxText(0, 0);
				text.color = 0x000000;
				text.text = file.name;

				g.push(text);

				var object = new UIObject();
				object.makeGraphic(text.width.int(), 14, 0x00000000);
				object.pressedCallback.add((?_) -> {
					trace("hi");
					current = f;
					refresh();
				});

				g.push(object);

				var delete_button = new UIButton(14);
				delete_button.color = 0xff0000;
				delete_button.text.text = "X";
				delete_button.x = width - 20;
				delete_button.pressedCallback.add((?_) -> {
					file.destroy();
					refresh();
				});

				g.push(delete_button);

				return g;

			case Folder(folder):
				var g:Array<FlxSprite> = [];
        
				var text = new FlxText(0, 0);
				text.color = 0x000000;
				text.text = '${folder.name}/';

				g.push(text);

				var object = new UIObject();
				object.makeGraphic(text.width.int(), 14, 0x00000000);
				object.pressedCallback.add((?_) -> {
					trace("hsdfgi");
					current = f;
					refresh();
				});

				g.push(object);

				var delete_button = new UIButton(14);
				delete_button.color = 0xff0000;
				delete_button.text.text = "X";
				delete_button.x = width - 20;
				delete_button.pressedCallback.add((?_) -> {
					folder.destroy();
					refresh();
				});

				g.push(delete_button);

				return g;

			case null:
				return [];
		}
  }

	var tracked = [];

	public function refresh() {
		for (t in tracked)
			body.remove(t);
		tracked = [];

		switch current {
			case Folder(folder):
				if (folder.children.length != 0)
					for (i => f in folder.children) {
						var objs = make_file(f);
						for (obj in objs) {
							tracked.push(obj);
							obj.y = topbar_offset + obj.height * i;
							body.add(obj);
						}
					}
				else {
					var text = new FlxText(48, topbar_offset + 22, "empty...");
					text.size = 20;
					// var text = new FlxText(0, 0);
					text.color = 0x3F3F3F;
					// text.text = file.name;
					tracked.push(text);

					body.add(text);
				}


			case File(file):
				var text = new FlxText(0, topbar_offset, width - 10, file.content);
				text.fieldHeight = height - 30;
				text.color = 0x000000;
				// text.text = file.name;
				tracked.push(text);

				body.add(text);
			case null:
				var children = FileSystem.get(C).children;
				if (children.length != 0)
					for (i => f in children) {
						trace(i, f);
						var objs = make_file(f);
						for (obj in objs) {
							tracked.push(obj);
							obj.y = topbar_offset + obj.height * i;
							body.add(obj);
						}
					}
				else {
					var text = new FlxText(20, topbar_offset, "what\nhave\nyou\ndone");
					text.size = 18;
					// var text = new FlxText(0, 0);
					text.color = 0x782E2E;
					// text.text = file.name;
					tracked.push(text);

					body.add(text);
				}
		}
	}
}