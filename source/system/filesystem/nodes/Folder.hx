package system.filesystem.nodes;

import system.filesystem.nodes.Drive;

final class Folder extends Drive {
  public function new(name: String) {
    super(cast name); // shhhh
	}
	override function destroy() {
		super.destroy();
		parent.delete(parent.find(this));
	}
}
