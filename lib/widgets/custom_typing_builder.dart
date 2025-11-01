import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

/// {@category Default widgets}
class CustomTypingBuilder extends StatelessWidget {
  const CustomTypingBuilder({
    required this.user,
    this.text = 'is typing',
    this.textStyle = const TextStyle(fontSize: 12),
    this.userTextStyle =
        const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    Key? key,
  }) : super(key: key);

  /// User that is typing
  final ChatUser user;
  final TextStyle textStyle;
  final TextStyle userTextStyle;

  /// Text to show after user's name in the indicator
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(right: 2),
            child: TypingIndicator(),
          ),
          Text(
            user.getFullName(),
            style: userTextStyle,
          ),
          Text(
            ' $text',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
