import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:karebay/core/constants/costants.dart';
import 'widgets.dart';
import 'package:karebay/core/providers/providers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class BottomChatField extends StatefulWidget {
  const BottomChatField({
    super.key,
    required this.chatProvider,
  });

  final ChatProvider chatProvider;

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  final TextEditingController textController = TextEditingController();

  // focus node for the input field
  final FocusNode textFieldFocus = FocusNode();

  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    try {
      bool available = await speechToText.initialize();
      if (!available) {
        log('Speech-to-Text is not available');
      }
    } catch (e) {
      log('Failed to initialize Speech-to-Text: $e');
    }
  }

  Future<void> startListening() async {
    if (!_isListening) {
      _isListening = true;
      setState(() {});

      await speechToText.listen(
        onResult: onSpeechResult,
        localeId: 'id-ID',
      );
    }
  }

  Future<void> stopListening() async {
    if (_isListening) {
      await speechToText.stop();
      setState(() {
        _isListening = false;
      });

      // Send message when listening stops
      if (textController.text.isNotEmpty) {
        sendChatMessage(
          message: textController.text,
          chatProvider: widget.chatProvider,
          isTextOnly: true,
        );
      }
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      textController.text = result.recognizedWords;
      // Otomatis fokus pada input field saat teks dihasilkan
      textFieldFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    textController.dispose();
    textFieldFocus.dispose();
    super.dispose();
  }

  Future<void> sendChatMessage({
    required String message,
    required ChatProvider chatProvider,
    required bool isTextOnly,
  }) async {
    try {
      await chatProvider.sentMessage(
        message: message,
        isTextOnly: isTextOnly,
      );
    } catch (e) {
      log('error : $e');
    } finally {
      textController.clear();
      widget.chatProvider.setImagesFileList(listValue: []);
      textFieldFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasImages = widget.chatProvider.imagesFileList != null &&
        widget.chatProvider.imagesFileList!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).textTheme.titleLarge!.color!,
        ),
      ),
      child: Column(
        children: [
          if (hasImages) const PreviewImagesWidget(),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  if (!_isListening) {
                    await startListening();
                  } else {
                    await stopListening();
                  }
                },
                icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: _isListening ? Colors.red : Colors.black,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextField(
                  maxLines: 6,
                  minLines: 1,
                  focusNode: textFieldFocus,
                  controller: textController,
                  textInputAction: TextInputAction.send,
                  onSubmitted: widget.chatProvider.isLoading
                      ? null
                      : (String value) {
                          if (value.isNotEmpty) {
                            // send the message
                            sendChatMessage(
                              message: textController.text,
                              chatProvider: widget.chatProvider,
                              isTextOnly: hasImages ? false : true,
                            );
                          }
                        },
                  decoration: InputDecoration.collapsed(
                      hintText: 'Ask Karebay',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ),
              GestureDetector(
                onTap: widget.chatProvider.isLoading
                    ? null
                    : () {
                        if (textController.text.isNotEmpty) {
                          // send the message
                          sendChatMessage(
                            message: textController.text,
                            chatProvider: widget.chatProvider,
                            isTextOnly: hasImages ? false : true,
                          );
                        }
                      },
                child: Container(
                    decoration: BoxDecoration(
                      color: Pallete.charcoalBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(5.0),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_upward, color: Colors.white),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
