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

class Internet extends Window {
  public function new() {
    super();

    title.text = "Internet";

		var text = new FlxText(0, 0, 0, "hi");
		text.color = 0x000000;
		body.add(text);
	}
}