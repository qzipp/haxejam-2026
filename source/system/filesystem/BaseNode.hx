package system.filesystem;

import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import flixel.util.FlxSignal;
import system.filesystem.nodes.Folder;

interface IFileNode extends IFlxDestroyable {
  public var name: String;
  public var parent: Folder;
  public function destroy(): Void;
}

class BaseNode<T:BaseNode<T>> implements IFileNode {
  public var name: String;
  public var parent: Folder;

  public var onDestroy: FlxTypedSignal<T->Void> = new FlxTypedSignal<T->Void>();
  public var onCreate: FlxTypedSignal<T->Void> = new FlxTypedSignal<T->Void>();

  public function new(name: String) {
    this.name = name;
  }

  public function destroy(): Void {
    onDestroy.dispatch(cast this);
  }
}
