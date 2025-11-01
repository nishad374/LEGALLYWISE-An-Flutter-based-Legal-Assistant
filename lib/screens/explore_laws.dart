import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legallywise/configs/constants.dart';
import 'package:legallywise/screens/result_page.dart';
import '../widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import "package:legallywise/screens/homescreen.dart";

class ExploreLaws extends StatelessWidget {
  const ExploreLaws({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(lawscreenTitle),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow[600],
      ),
      backgroundColor: Colors.black,
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                } else {
                  return searchSections(textEditingValue.text);
                }
              },
              // optionsViewBuilder: ((context, onSelected, options) => {}),
              fieldViewBuilder: ((context, textEditingController, focusNode,
                      onEditingComplete) =>
                  TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onEditingComplete: onEditingComplete,
                    style: const TextStyle(color: Colors.white70),
                    // exposed text field
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Search IPC Section',
                        prefixIcon: Icon(Icons.search)),
                  )),
              onSelected: (String selection) {
                // Extract chapter number from selection
                final regex = RegExp(r'Chapter (\d+)');
                final match = regex.firstMatch(selection);
                if (match != null) {
                  final chapterId = match.group(1);
                  _fetchAndNavigate(context, chapterId!);
                }
              },
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       prefixIcon: const Icon(Icons.search),
          //       hintText: "Explain IPC Section",
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10.0),
          //         borderSide:
          //             const BorderSide(width: 1.0, style: BorderStyle.solid),
          //       ),
          //     ),
          //   ),
          // ),
          const Divider(),
          const Text(
            'Explore By Categories',
            style: TextStyle(color: Colors.white70),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              clipBehavior: Clip.antiAlias,
              children: [
                // TODO: For now implemenation for each card is done manually, must get updated with any Buildermethod in future
                CategoryCard(
                  text: "Introduction to IPC",
                  image: const AssetImage('assets/introduction_to_ipc.jpg'),
                  onTap: () => _fetchAndNavigate(context, '1'),
                ),
                CategoryCard(
                  text: "General Explainations",
                  image: const AssetImage('assets/general_explainations.jpg'),
                  onTap: () => _fetchAndNavigate(context, '2'),
                ),
                CategoryCard(
                  text: "Punishments",
                  image: const AssetImage('assets/punishment.jpg'),
                  onTap: () => _fetchAndNavigate(context, '3'),
                ),
                CategoryCard(
                  text: "General Exceptions",
                  image: const AssetImage('assets/general_exception.jpg'),
                  onTap: () => _fetchAndNavigate(context, '4'),
                ),
                CategoryCard(
                  text: "Abetment",
                  image: const AssetImage('assets/abetment.jpg'),
                  onTap: () => _fetchAndNavigate(context, '5'),
                ),
                CategoryCard(
                  text: "Offense Against the State",
                  image:
                      const AssetImage('assets/offense_against_the_state.jpg'),
                  onTap: () => _fetchAndNavigate(context, '6'),
                ),
                CategoryCard(
                  text: "Offense related to navy, army, airforce",
                  image: const AssetImage('assets/offense_related_to_army.jpg'),
                  onTap: () => _fetchAndNavigate(context, '7'),
                  image_fit: BoxFit.cover,
                  image_alignment: Alignment.topCenter,
                ),
                CategoryCard(
                  text: "Offense against the Public tranquillity",
                  image: const AssetImage(
                      'assets/offense_against_the_public_tranquillity.jpg'),
                  onTap: () => _fetchAndNavigate(context, '8'),
                ),
                CategoryCard(
                  text: "Offense by or relating to Public servants",
                  image: const AssetImage(
                      'assets/offense_by_or_relating_to_public_servants.jpg'),
                  onTap: () => _fetchAndNavigate(context, '9'),
                ),
                CategoryCard(
                  text: "Contempt's the lawful authority public servants",
                  image: const AssetImage(
                      'assets/contempt_the_lawful_authority_public_servants.jpg'),
                  onTap: () => _fetchAndNavigate(context, '10'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Iterable<String>> searchSections(String query) async {
    final firestore = FirebaseFirestore.instance;
    final queryResult = await firestore
        .collectionGroup('sections')
        .where('section_number', isEqualTo: int.parse(query))
        .get();

    List<String> results = [];

    await Future.forEach(queryResult.docs, (QueryDocumentSnapshot doc) async {
      final sectionRef = doc.reference;
      final chapterRef =
          sectionRef.parent.parent; // Get the parent chapter document
      final chapterDoc = await chapterRef?.get();
      final chapterNumber = chapterDoc?['chapter']; // Get the chapter number

      results.add(
          "#${doc['section_number'].toString()} - ${doc['section_title'].toString()} (Chapter $chapterNumber)");
    });

    return results;
  }

  void _fetchAndNavigate(BuildContext context, String chapterId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(), // Spinner while fetching
        );
      },
    );

    getChapter(chapterId).then((data) {
      Navigator.pop(context); // Close the spinner

      if (data != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPageTemplate(
              chapterNumber: data['chapter_number'],
              chaptertitle: data['chapter_name'],
              sections: data['sections'],
            ),
          ),
        );
      } else {
        print('Chapter does not exist');
      }
    });
  }

  Future<Map<String, dynamic>?> getChapter(String chapterId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference document =
        firestore.collection('chapters').doc(chapterId);

    final chapterSnapshot = await document.get();
    if (chapterSnapshot.exists) {
      final chapterData = chapterSnapshot.data() as Map<String, dynamic>;
      final chapterName = chapterData['chapter_title'];
      final chapterNumber = chapterData['chapter'];

      // Retrieve sections
      final sectionsRef = document.collection('sections');
      final sectionsSnapshot = await sectionsRef.get();

      // Process sections
      final sections = sectionsSnapshot.docs.map((sectionDoc) {
        final sectionData = sectionDoc.data();
        // Process section data as needed
        return sectionData;
      }).toList();

      // Return chapter details and sections
      return {
        'chapter_name': chapterName,
        'chapter_number': chapterNumber,
        'sections': sections,
      };
    } else {
      print('Chapter does not exist');
      return null;
    }
  }
}

class CategoryCard extends StatelessWidget {
  final String text;
  final AssetImage image;
  final Color backgroundColor;
  final TextStyle textStyle;
  final BoxFit image_fit;
  final Alignment image_alignment;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.text,
    required this.image,
    this.backgroundColor = Colors.white,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    this.image_fit = BoxFit.cover,
    this.image_alignment = Alignment.center,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          // color: backgroundColor,
          image: DecorationImage(
              image: image,
              fit: image_fit,
              alignment: image_alignment,
              colorFilter: const ColorFilter.mode(
                  Color.fromARGB(180, 0, 0, 0), BlendMode.srcOver)),
        ),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text.toUpperCase(),
          style: GoogleFonts.averiaLibre(textStyle: textStyle),
        ),
      ),
    );
  }
}
