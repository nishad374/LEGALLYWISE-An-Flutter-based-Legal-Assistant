import "package:flutter/material.dart";
import 'package:flutter_markdown/flutter_markdown.dart';

class ResultPageTemplate extends StatelessWidget {
  final int chapterNumber;
  final String chaptertitle;
  final List sections;

  const ResultPageTemplate(
      {super.key,
      required this.chapterNumber,
      required this.chaptertitle,
      required this.sections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 9.0),
              child: Text(
                chaptertitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sections.length,
                itemBuilder: (context, idx) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: const Color.fromRGBO(48, 48, 48, 1),
                          padding: const EdgeInsets.all(11),
                          child: MarkdownBody(
                              data:
                                  '''### Section: #${sections[idx]['section_number']}
                          \n\n__${sections[idx]['section_title']}__
                          \n\n${sections[idx]['section_description']}''',
                              styleSheet: MarkdownStyleSheet(
                                h3: TextStyle(color: Colors.yellow.shade700),
                                p: const TextStyle(
                                    color: Color.fromARGB(200, 255, 255, 255)),
                              ),
                              shrinkWrap: true),
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
