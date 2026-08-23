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

class BaseNode implements IFileNode {
  public var name: String;
  public var parent: Drive;

  public function new(name: String) {
    this.name = name;
  }

	public var onCreate = new FlxTypedSignal<Void->Void>();
	public var onDestroy = new FlxTypedSignal<Void->Void>();

  public function destroy(): Void {
		onDestroy.dispatch();

    onDestroy?.destroy();
    onCreate?.destroy();
  }
}
