import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScQu extends StatelessWidget {
  const ScQu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF79C5F7),
        automaticallyImplyLeading:
            false, // This will hide the default back arrow
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right:
                      190), // Adding a small space on the right side of the first icon
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x49D9D9D9),
                ),
                child: IconButton(
                  icon: Image.asset(
                    'images/plus.png',
                    width: 20,
                    height: 20,
                  ),
                  onPressed: () {
                    // Add button onPressed action
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                'علوم',
                style: GoogleFonts.radioCanada(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x49D9D9D9),
              ),
              child: IconButton(
                icon: Image.asset(
                  'images/next.png',
                  width: 25,
                  height: 25,
                ),
                onPressed: () {
                  Navigator.pop(context); // Next button onPressed action
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(
                    0xFF79C5F7), // Setting the background color of the body to purple
              ),
              child: Column(
                children: [
                  const SizedBox(height: 79), // Adjust the height as needed
                  Container(
                    height: 646,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'قائمة الأسئلة',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'السؤال',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 30),
                          Container(
                            height: 1,
                            color: const Color(0xFFF2E5FF),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'السؤال',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 30),
                          Container(
                            height: 1,
                            color: const Color(0xFFF2E5FF),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'السؤال',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 30),
                          Container(
                            height: 1,
                            color: const Color(0xFFF2E5FF),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'السؤال ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 30),
                          Container(
                            height: 1,
                            color: const Color(0xFFF2E5FF),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'السؤال',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 30),
                          Container(
                            height: 1,
                            color: const Color(0xFFF2E5FF),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'السؤال',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 30),
                          Container(
                            height: 1,
                            color: const Color(0xFFF2E5FF),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
