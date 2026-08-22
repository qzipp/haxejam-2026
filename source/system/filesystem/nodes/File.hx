package system.filesystem.nodes;

final class File extends BaseNode<File> {
  public var extension: String;

  private inline function getExtension(name: String): String {
    final lastDotThingy = name.lastIndexOf(".");
    if(lastDotThingy <= 0)
      return "";
    return name.substr(lastDotThingy + 1);
  }

  public function new(name: String) {
    super(name);
    extension = this.getExtension(name);
   // onCreate.dispatch(this);
  }
}
