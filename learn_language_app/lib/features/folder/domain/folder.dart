import 'package:learn_language_app/features/folder/domain/note_file.dart';

class FolderNode {
  final String id;
  final String title;
  final bool isFolder;
  final List<FolderNode> children;
  final List<NoteFile> notes;
  final String? content;
  final DateTime? reminderTime; // Thêm dòng này để tránh lỗi

  FolderNode({
    required this.id,
    required this.title,
    required this.isFolder,
    required this.children,
    this.notes = const [],
    this.content,
    this.reminderTime,
  });

  FolderNode copyWith({
    String? id,
    String? title,
    bool? isFolder,
    List<FolderNode>? children,
    List<NoteFile>? notes,
    String? content,
    DateTime? reminderTime,
  }) {
    return FolderNode(
      id: id ?? this.id,
      title: title ?? this.title,
      isFolder: isFolder ?? this.isFolder,
      children: children ?? this.children,
      notes: notes ?? this.notes,
      content: content ?? this.content,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }
}
