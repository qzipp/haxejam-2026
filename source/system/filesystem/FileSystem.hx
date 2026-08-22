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

  static public function init() {
    var c_drive = new Drive(C);

    var file = new File("orbl.txt", "stinks");
    var file_2 = new File("qzip.txt", "stinks more");
    var ffff = new Folder("truths");

    ffff.add(File(file_2));

    c_drive.add(File(file));

    c_drive.add(Folder(ffff));

    drives.push(c_drive);

    switch c_drive.get("orbl.txt") {
      case File(file):
        trace(file.content);
      case _:
        throw "Wat";
    }

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