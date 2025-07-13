// class FileNote {
//   final String title;
//   final String content;

//   FileNote({required this.title, required this.content});
// }

// class Folder {
//   final String name;
//   final List<Folder> subFolders;
//   final List<FileNote> files;

//   Folder({
//     required this.name,
//     List<Folder>? subFolders,
//     List<FileNote>? files,
//   })  : subFolders = subFolders ?? [],
//         files = files ?? [];
// }
class FolderNode {
  final String id;
  final String title;
  final bool isFolder;
  final List<FolderNode> children;

  FolderNode({
    required this.id,
    required this.title,
    required this.isFolder,
    this.children = const [],
  });
}