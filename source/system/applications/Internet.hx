package system.applications;

import flixel.FlxG;
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

class Internet extends Window {
	final lil_offset = 24; 
  public function new() {
    super();

		window_background.color = switch FlxG.random.int(0, 3) {
			case 0: 0x004400;
			case 1: 0x004442;
			case 2: 0x521D51;
			case _: 0x440000;
		}

    title.text = "Internet";

		var text = new FlxText(0, 0, 0, "kttp:\\\\shady-website.lol");
		text.color = 0xFFFFFF;
		body.add(text);
		var download_virus = new UIButton(98);
		download_virus.y = lil_offset;
		// random list of buttons for some website lol
		download_virus.text.text = "free ram download";
		download_virus.pressedCallback.addOnce((?_) -> {
			@:privateAccess Layers.background.members = [];
			Layers.background.add(new FlxSprite().loadGraphic(AssetPaths.shitpaper1__png));
		});
		body.add(download_virus);
	}
}