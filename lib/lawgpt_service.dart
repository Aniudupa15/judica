import 'dart:convert';
import 'package:http/http.dart' as http;

class LawGPTService {
  final String baseUrl = "http://localhost:8000"; // Replace with your server's IP or domain

  Future<String> askQuestion(String question, List<String> chatHistory) async {
    final response = await http.post(
      Uri.parse("$baseUrl/chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "question": question,
        "chat_history":"hello"
        // chatHistory,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData["answer"];
    } else {
      throw Exception("Failed to get response: ${response.statusCode}");
    }
  }
}
