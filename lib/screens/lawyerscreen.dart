import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legallywise/widgets/app_drawer.dart';

class LawyerListScreen extends StatelessWidget {
  const LawyerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(100, 62, 57, 57),
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Hire Lawyers"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: 'Connect to Professional ',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: 'Lawyer',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                ]),
              ),
              // const SizedBox(height: 25),

              const Divider(thickness: 2, color: Colors.white),
              const Center(
                child: Text(
                  'Top Lawyers',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              // const SizedBox(height: 25),
              const Divider(thickness: 2, color: Colors.white),
              const SizedBox(height: 10),
              LawyerCard(
                name: 'Raghav Pandey',
                qualification: '-LLB',
                contact: '+91 9168976543',
                location: 'Mumbai 400-016',
                socialMediaIcons: [
                  Image.asset('assets/fb_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/lnkdn_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/wa_icon.jpg', width: 24, height: 24),
                ],
                // Replace with your social media icon
              ),
              const SizedBox(height: 16),
              LawyerCard(
                name: 'Ishal Mishra',
                qualification: '-BBA, LLB',
                contact: '+91 9167897703',
                location: 'Mumbai 400-009',
                socialMediaIcons: [
                  Image.asset('assets/fb_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/lnkdn_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/wa_icon.jpg',
                      width: 24,
                      height: 24), // Replace with your social media icons
                ],
              ),
              const SizedBox(height: 16),
              LawyerCard(
                name: 'Zayn Satvelkar',
                qualification: '-BBA, LLB',
                contact: '+91 9345529703',
                location: 'Mumbai 400-011',
                socialMediaIcons: [
                  Image.asset('assets/fb_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/lnkdn_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/wa_icon.jpg',
                      width: 24,
                      height: 24), // Replace with your social media icons

                  // Replace with your social media icons
                ],
              ),
              const SizedBox(height: 16),
              LawyerCard(
                name: 'Naseem Khan',
                qualification: '-BBA, LLB',
                contact: '+91 9123456703',
                location: 'Mumbai 400-009',
                socialMediaIcons: [
                  Image.asset('assets/fb_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/lnkdn_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/wa_icon.jpg', width: 24, height: 24),
                  // Replace with your social media icons
                ],
              ),
              const SizedBox(height: 16),
              LawyerCard(
                name: 'Siddique Shaikh',
                qualification: '-BBA, LLB',
                contact: '+91 9167529703',
                location: 'Mumbai 400-001',
                socialMediaIcons: [
                  Image.asset('assets/fb_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/lnkdn_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/wa_icon.jpg', width: 24, height: 24),
                ],
              ),
              const SizedBox(height: 16),
              LawyerCard(
                name: 'Harshit mehta',
                qualification: '-BBA, LLB',
                contact: '+91 9161234656',
                location: 'Mumbai 400-006',
                socialMediaIcons: [
                  Image.asset('assets/fb_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/lnkdn_icon.jpg', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Image.asset('assets/wa_icon.jpg', width: 24, height: 24),
                  // Replace with your social media icons
                ],
              ),

              const SizedBox(height: 16),
              // Add more LawyerCard widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}

class LawyerCard extends StatelessWidget {
  final String name;
  final String qualification;
  final String contact;
  final String location;
  final List<Widget> socialMediaIcons;

  const LawyerCard({
    super.key,
    required this.name,
    required this.qualification,
    required this.contact,
    required this.location,
    required this.socialMediaIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 60, 57, 57),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Icon(
              Icons.person_2,
              color: Color.fromARGB(244, 255, 255, 255),
              size: 110,
            ),
          ),
          const VerticalDivider(
            color: Colors.white,
            thickness: 1,
          ),
          // const SizedBox(width: 10), // Adjust spacing as needed
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 8.0),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.grey,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    qualification,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Contact: $contact',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: $location',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 4, top: 11),
                      child: Row(children: socialMediaIcons)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
