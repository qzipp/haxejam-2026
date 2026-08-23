package system.filesystem.nodes;

final class File extends BaseNode {
  public var extension: String;

  public var content: String;

  private inline function getExtension(name: String): String {
    final lastDotThingy = name.lastIndexOf(".");
    if(lastDotThingy <= 0)
      return "";
    return name.substr(lastDotThingy + 1);
  }

  public function new(name: String, ?content: String = "") {
    super(name);
    extension = this.getExtension(name);
    this.content = content;
   // onCreate.dispatch(this);
  }
	override function destroy() {
		super.destroy();
		parent.delete(parent.find(this));
	}
}
