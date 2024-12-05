import 'package:flutter/material.dart';
import 'lawgpt_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final LawGPTService service = LawGPTService();
  final List<Map<String, String>> chatHistory = []; // Store as question-answer pairs
  final TextEditingController controller = TextEditingController();
  bool isLoading = false; // Indicate loading state

  void askQuestion() async {
    if (controller.text.trim().isEmpty) return; // Prevent empty questions

    setState(() {
      isLoading = true;
    });

    try {
      final question = controller.text;
      final answer = await service.askQuestion(
        question,
        chatHistory.map((entry) => entry["question"]!).toList(),
      );

      setState(() {
        chatHistory.add({"question": question, "answer": answer});
      });
      controller.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Chat history display
          Expanded(
            child: ListView.builder(
              itemCount: chatHistory.length,
              itemBuilder: (context, index) {
                final entry = chatHistory[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        "You: ${entry['question']}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      tileColor: Colors.grey[300],
                    ),
                    ListTile(
                      title: Text("LawGPT: ${entry['answer']}"),
                      tileColor: Colors.white,
                    ),
                  ],
                );
              },
            ),
          ),
          // Loading indicator
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          // Input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Ask a question...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                  onPressed: askQuestion,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
