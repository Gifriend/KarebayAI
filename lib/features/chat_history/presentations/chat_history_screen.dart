import 'package:flutter/material.dart';
import 'package:karebay/core/constants/themes/widgets/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:karebay/features/onboarding/login/presentations/login_screen.dart';

import '../../../core/constants/auth/auth_sevice.dart';
import '../../../core/constants/costants.dart';
import '../../../core/models/models.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () async {
              authServicesProvider.signOut();
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
          backgroundColor: Pallete.charcoalBlue,
          centerTitle: true,
          title: const Text(
            'Chat history',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: ValueListenableBuilder<Box<ChatHistory>>(
          valueListenable: Boxes.getChatHistory().listenable(),
          builder: (context, box, _) {
            final chatHistory =
                box.values.toList().cast<ChatHistory>().reversed.toList();
            return chatHistory.isEmpty
                ? const EmptyHistoryWidget()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: chatHistory.length,
                      itemBuilder: (context, index) {
                        final chat = chatHistory[index];
                        return ChatHistoryWidget(chat: chat);
                      },
                    ),
                  );
          },
        ));
  }
}
