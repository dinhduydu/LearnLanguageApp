class NotionNote {
  final String id;
  final String title;
  final bool favourite;
  final bool isPrivate;
  final String? content;

  NotionNote({
    required this.id,
    required this.title,
    required this.favourite,
    required this.isPrivate,
    this.content,
  });

  factory NotionNote.fromJson(Map<String, dynamic> json) {
    return NotionNote(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      favourite: json['favourite'] ?? false,
      isPrivate: json['isPrivate'] ?? false,
      content: json['content'],
    );
  }
}