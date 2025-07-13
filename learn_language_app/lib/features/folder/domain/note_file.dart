class NoteFile {
  final String id;
  final String title;
  final String content;
  final DateTime? reminderTime; // <-- Reminder ở đây

  NoteFile({
    required this.id,
    required this.title,
    required this.content,
    this.reminderTime,
  });
}