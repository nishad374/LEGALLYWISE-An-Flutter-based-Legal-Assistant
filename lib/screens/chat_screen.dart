import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:dash_chat_2/dash_chat_2.dart";
import "package:legallywise/configs/constants.dart";
import 'package:flutter_markdown/flutter_markdown.dart';
import "package:google_generative_ai/google_generative_ai.dart";
import "package:legallywise/widgets/custom_typing_builder.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late ChatUser _chatUser;

  @override
  void initState() {
    super.initState();
    _chatUser = ChatUser(id: "1", firstName: user?.displayName);
  }

  final _llm = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: GEMINI_API_KEY,
    systemInstruction: Content.system(SYSTEM_PROMPT),
  );

  final ChatUser _aiUser =
      ChatUser(id: "2", firstName: "AI", lastName: "Lawyer");

  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DashChat(
          currentUser: _chatUser,
          typingUsers: _typingUsers,
          inputOptions: InputOptions(
            alwaysShowSend: true,
            sendButtonBuilder: defaultSendButton(color: Colors.yellow),
            inputTextStyle: const TextStyle(color: Colors.white70),
            inputDecoration: InputDecoration(
              fillColor: Colors.grey.shade900,
              filled: true,
              hintText: "Write a Message",
              hintStyle: TextStyle(
                inherit: false,
                color: Colors.grey.shade600,
              ),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.yellow.shade500, width: 0.9),
                borderRadius: BorderRadius.circular(20),
                gapPadding: 1.0,
              ),
            ),
          ),
          messageOptions: MessageOptions(
            currentUserContainerColor: Colors.grey.shade900,
            currentUserTextColor: Colors.white60,
            containerColor: Colors.grey.shade900,
            textColor: Colors.white70,
            markdownStyleSheet: MarkdownStyleSheet(
                h1: TextStyle(color: Colors.yellow.shade600),
                h2: TextStyle(color: Colors.yellow.shade600),
                h3: TextStyle(color: Colors.yellow.shade600),
                p: const TextStyle(color: Colors.white70),
                a: TextStyle(color: Colors.blue[400]),
                listBullet: const TextStyle(color: Colors.white70)),
          ),
          messageListOptions: MessageListOptions(
            typingBuilder: (chatuser_) {
              return CustomTypingBuilder(
                user: chatuser_,
                textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
                userTextStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          onSend: getChatResponse,
          messages: _messages),
    );
  }

  Future<void> getChatResponse(ChatMessage msg) async {
    setState(() {
      // Adding user message to chat
      _messages.insert(
          0,
          ChatMessage(
            user: _chatUser,
            createdAt: DateTime.now(),
            text: msg.text.trim(),
          ));

      // Adding typing effect
      _typingUsers.add(_aiUser);
    });

    // Fetching Entire previous conversations
    List<Content> messageHistory = _messages.reversed.map(
      (msg) {
        if (msg.user == _chatUser) {
          return Content.text(msg.text);
        } else {
          return Content.model([TextPart(msg.text)]);
        }
      },
    ).toList();

    // Getting Response based on the context

    final chat = _llm.startChat(
      history: messageHistory,
      generationConfig: GenerationConfig(
        temperature: 0.75,
        maxOutputTokens: 512,
      ),
    );

    final response = await chat.sendMessage(Content.text(msg.text));

    // Updating the state
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
            user: _aiUser,
            createdAt: DateTime.now(),
            isMarkdown: true,
            text: response.text ?? "Something Went Wrong!"),
      );

      _typingUsers.remove(_aiUser);
    });
  }
}
