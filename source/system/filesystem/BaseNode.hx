package system.filesystem;

import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import flixel.util.FlxSignal;
import system.filesystem.NodeType;
import system.filesystem.nodes.Drive;
import system.filesystem.nodes.Folder;

interface IFileNode extends IFlxDestroyable {
  public var name: String;
  public var parent: Drive;
  public function destroy(): Void;
}

class BaseNode<T = NodeType> implements IFileNode {
  public var name: String;
  public var parent: Drive;

  public function new(name: String) {
    this.name = name;
  }

  public var onCreate = new FlxTypedSignal<T->Void>();
  public var onDestroy = new FlxTypedSignal<T->Void>();

  public function destroy(): Void {
    onDestroy.dispatch(cast this);
    onDestroy?.destroy();
    onCreate?.destroy();
  }
}
