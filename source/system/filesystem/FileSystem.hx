package system.filesystem;

import system.filesystem.nodes.Drive;
import system.filesystem.nodes.File;
import system.filesystem.nodes.Folder;

class FileSystem {
  static public var drives = new Array<Drive>();

  // gwuh?
  //   static public var cwd: Folder;

  static public function get(letter: DriveLetter) {
    for(drive in drives) {
      if(drive.name == letter)
        return drive;
    }

    return null;
  }

	static public final core_file_content = "package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import openfl.display.Sprite;
import scenes.Game;

class Main extends Sprite
{
	public function new()
	{
		super();
    addChild(new FlxGame(320, 240, Game, 60, 60, true, false));
		FlxG.scaleMode = new PixelPerfectScaleMode();
	}
}
";

  static public function init() {
    var c_drive = new Drive(C);

		var system = new Folder("sys");
		var notice = new File("DO-NOT-DELETE-THIS", "deleting any file in this folder is going to cause system instability");
		var core = new File("core", core_file_content);
		core.onDestroy.add(_ -> {
			State.DELETED_CORE = true;
			State.DELETED_CORE_SIGNAL.dispatch();
		});
    

		system.add(File(notice));
		system.add(File(core));

		c_drive.add(Folder(system));

    drives.push(c_drive);

    trace(c_drive);
    // root = new Folder("C:");
    // // cwd = root;
    // final test_file: File = new File("meow.txt");

    // root.onCreate.add((file) -> {
    //   trace(file.extension);
    //   trace(file.name);
    // });
    // // test_file.onCreate.dispatch(e);
    // root.onCreate.dispatch(test_file);
    // root.children.set(test_file.name, test_file);
  }

  // todo scary stuff next
}