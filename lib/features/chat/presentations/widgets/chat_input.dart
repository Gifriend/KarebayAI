import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key, required this.onSend});
  final void Function(String) onSend;

  @override
  Widget build(BuildContext context) {
    final TextEditingController chatController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45.0,
              child: TextField(
                controller: chatController,
                decoration: InputDecoration(
                  hintText: 'Ask questions',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.newline,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: GestureDetector(
              onTap: () {
                if (chatController.text.isNotEmpty) {
                  onSend(chatController.text);
                  chatController.clear();
                }
              },
              child: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
