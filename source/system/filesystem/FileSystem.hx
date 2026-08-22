package system.filesystem;

import system.filesystem.nodes.File;
import system.filesystem.nodes.Folder;

class FileSystem {
    public var root:Folder;
    public var cwd:Folder;

    public function new()
    {
        root = new Folder("C:");
        cwd = root;
        final e:File = new File("meow.txt");
        e.onCreate.add((file)->{
            trace(file.extension);
            trace(file.name);
        });
        e.onCreate.dispatch(e);
        root.children.set('meow', e);
    }

    // todo scary stuff next
}