package system.filesystem;

import system.filesystem.nodes.File;
import system.filesystem.nodes.Folder;

enum NodeType {
  File(file: File);
  Folder(folder: Folder);
}