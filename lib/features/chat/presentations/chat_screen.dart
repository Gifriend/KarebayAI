import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karebay/core/constants/costants.dart';
import 'package:karebay/features/chat/presentations/widgets/chat_input.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final List<String> messages = [];

  void _handleMessageSend(String message) {
    setState(() {
      messages.add(message);
    });

    // Simulasi respons AI
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add('AI Response: $message');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Pallete.paleGray,
        appBar: AppBar(
          backgroundColor: Pallete.deepOceanBlue,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Pallete.lightGrey,
              )),
          title: const Text(
            'KarebayChat',
            style: TextStyle(
              color: Pallete.lightGrey,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final isUserMessage = index % 2 == 0;
                  return Container(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      messages[index],
                      style: TextStyle(
                        color: isUserMessage
                            ? Pallete.deepOceanBlue
                            : Pallete.mainFontColor,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
            ChatInput(
              onSend: _handleMessageSend,
            ),
          ],
        ),
      ),
    );
  }
}
