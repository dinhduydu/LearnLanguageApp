import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_language_app/features/folder/domain/folder.dart';

class NotionService {
  final String token;
  final String databaseId;

  NotionService({required this.token, required this.databaseId});

  Future<List<FolderNode>> fetchNotionFolders() async {
    final url = Uri.parse('https://api.notion.com/v1/databases/$databaseId/query');
    final res = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode != 200) {
      throw Exception('Lỗi API Notion: ${res.body}');
    }

    final json = jsonDecode(res.body);
    final results = json['results'] as List;

    return results.map((item) {
      final properties = item['properties'];
      final title = properties['Name']?['title']?[0]?['text']?['content'] ?? 'Untitled';

      return FolderNode(
        id: item['id'],
        title: title,
        isFolder: false,
        children: [],
        content: '', // có thể bổ sung nội dung thật nếu lấy được
      );
    }).toList();
  }
}
