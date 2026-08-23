package system.filesystem.nodes;

import flixel.util.FlxSignal.FlxTypedSignal;
import system.filesystem.nodes.File;

enum abstract DriveLetter(String) to String {
  final C = "C";
  final D = "D";
  final CAT = "🐈‍⬛";
  // i don car about the rest Lol
}

class Drive extends BaseNode {
  public var children = new Array<NodeType>();

  public var onRemove = new FlxTypedSignal<NodeType->Void>();
  public var onAdd = new FlxTypedSignal<NodeType->Void>();

  public function new(name: DriveLetter) {
    super(name);
  }

  public function get(name: String) {
    for(child in children)
      switch child {
        case File(f) if(f.name == name):
          return child;

        case Folder(f) if(f.name == name):
          return child;

        case _:
          continue;
      }

    return null;
  }

  public function add(f: NodeType)
    move(f);

  public function move(f: NodeType) {
    switch f {
      case File(file) if(file.parent != null):
        file.parent.children.remove(f);

        file.parent = this;

      case Folder(folder) if(folder.parent != null):
        folder.parent.children.remove(f);

        folder.parent = this;

      case _:
        null;
    }

    children.push(f);
  }

  public override function destroy(): Void {
    for(child in children)
      switch child {
        case File(file):
          file.destroy();

        case Folder(folder):
          folder.destroy();
      }

    children = [];
    super.destroy(); // u forgor
  }

  public function toString() {
    return '${Type.getClassName(Type.getClass(this))} $name (${children.length}): [${children.map(f -> {
      var f = switch f {
        case File(f): f;
        case Folder(f): f;
      }

      return f.name;
    }).join(", ")}]';
  }
}
