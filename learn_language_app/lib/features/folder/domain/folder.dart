class FileNote {
  final String title;
  final String content;

  FileNote({required this.title, required this.content});
}

class Folder {
  final String name;
  final List<Folder> subFolders;
  final List<FileNote> files;

  Folder({
    required this.name,
    List<Folder>? subFolders,
    List<FileNote>? files,
  })  : subFolders = subFolders ?? [],
        files = files ?? [];
}
