import 'package:flutter/material.dart';
import 'lawgpt_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final LawGPTService service = LawGPTService();
  final List<String> chatHistory = [];
  final TextEditingController controller = TextEditingController();
  String response = "";

  void askQuestion() async {
    try {
      final question = controller.text;
      final answer = await service.askQuestion(question, chatHistory);
      setState(() {
        chatHistory.addAll([question, answer]);
        response = answer;
      });
      controller.clear();
    } catch (e) {
      setState(() {
        response = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LawGPT Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatHistory[index]),
                  tileColor: index % 2 == 0 ? Colors.grey[200] : Colors.white,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Ask a question...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: askQuestion,
                ),
              ),
            ),
          ),
          if (response.isNotEmpty) Text("Response: $response"),
        ],
      ),
    );
  }
}
