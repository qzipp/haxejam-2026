package system.applications;

import flixel.text.FlxText;
import flixel.util.FlxTimer;
import objects.ui.UIButton;
import system.filesystem.FileSystem;
import system.filesystem.NodeType;
import system.windowing.Window;

class Explorator extends Window {
  var files: Array<NodeType>;

  public function new() {
    super();

    title.text = "Explorator";

    var text = new FlxText(50, 0, " Hi");
    body.add(text);

    var refresh_button = new UIButton();
    refresh_button.text.text = "refresh";
    refresh_button.x = 70;

    refresh();
    refresh_button.pressedCallback.add((?_) -> {
      trace("hi");
      refresh();
    });
    body.add(refresh_button);

    for(i => f in files)
      switch f {
        case File(file):
          var text = new FlxText(0, 0);
          text.y = text.height * i;
          text.color = 0x000000;
          text.text = file.name;

          body.add(text);

        case Folder(folder):
          var text = new FlxText(0, 0);
          text.y = text.height * i;
          text.color = 0x000000;
          text.text = '${folder.name}/';

          body.add(text);
      }

      FlxTimer.loop(1.0, (_) -> refresh(), 0);
  }

  public function refresh() {
    files = FileSystem.get(C).children;
  }
}