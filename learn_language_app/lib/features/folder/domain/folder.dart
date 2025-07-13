class FolderNode {
  final String id;
  final String title;
  final bool isFolder;
  final List<FolderNode> children;
  final String? content;         // <-- dùng content thay notes
  final DateTime? reminderTime; // <-- để hỗ trợ reminder

  FolderNode({
    required this.id,
    required this.title,
    required this.isFolder,
    this.children = const [],
    this.content,
    this.reminderTime,
  });
}