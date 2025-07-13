import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/notion_note.dart';

class NotionService {
  final String token;
  final String databaseId;

  NotionService({required this.token, required this.databaseId});

  Future<List<NotionNote>> fetchNotes() async {
    final url = Uri.parse('https://api.notion.com/v1/databases/$databaseId/query');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return results.map((e) => NotionNote.fromJson(_mapProperties(e))).toList();
    } else {
      throw Exception('Failed to load Notion notes');
    }
  }

  Map<String, dynamic> _mapProperties(Map<String, dynamic> page) {
    final props = page['properties'];
    return {
      'id': page['id'],
      'title': props['Name']?['title']?[0]?['plain_text'] ?? '',
      'favourite': props['Favourite']?['checkbox'] ?? false,
      'isPrivate': props['Private']?['checkbox'] ?? false,
      'content': null,
    };
  }
}