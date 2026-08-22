package system.filesystem.nodes;

import system.filesystem.BaseNode.IFileNode;

final class Folder extends BaseNode<Folder> {
  public var children: Map<String, IFileNode>;

  public function new(name: String) {
    super(name);
    children = new Map<String, IFileNode>();

    onCreate.add((fol) -> {
      trace('made uh Folder or smth $name');
    });
    onCreate.dispatch(this);
  }

  public override function destroy(): Void {
    for(child in children)
      child.destroy();
    children.clear();
  }
}
