class NotionService 
{
    final String apiKey;
    final String databaseId;

    NotionService({
        required this.apiKey,
        required this.databaseId,
    });

    Future<List<Map<String, dynamic>>> fetchPageContent() async {
        /* Gọi API Notion, trả về JSON dạng Map */
        /* Dùng http package hoặc dio */
    }
}