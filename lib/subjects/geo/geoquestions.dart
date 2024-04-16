import 'package:flutter/material.dart';
import 'package:mypfe/subjects/geo/add_geo_questions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypfe/subjects/geo/geo_choices.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GeoQu extends StatefulWidget {
  const GeoQu({super.key});

  @override
  State<GeoQu> createState() => _GeoQuState();
}

class _GeoQuState extends State<GeoQu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7D79F7),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 190),
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
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const AddGeoQuestionModal();
                      },
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                'جغرافيا',
                style: GoogleFonts.lateef(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 35,
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
                  Navigator.pop(context);
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
                color: Color(0xFF7D79F7),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 79),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Center(
                          child: Column(
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
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Geography')
                                        .snapshots(),
                                    builder: (context, geoSnapshot) {
                                      if (geoSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      final User? user =
                                          FirebaseAuth.instance.currentUser;
                                      final String? userId = user?.uid;
                                      List<QueryDocumentSnapshot>
                                          geoDocuments =
                                          geoSnapshot.data!.docs;

                                      return StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('Users')
                                            .doc(userId)
                                            // .doc('amouna') // Remplacez user_id par l'ID de l'utilisateur actuel
                                            .collection('question_added_geo')
                                            .snapshots(),
                                        builder: (context, userSnapshot) {
                                          if (userSnapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }

                                          List<QueryDocumentSnapshot>
                                              userDocuments =
                                              userSnapshot.data!.docs;

                                          List<QueryDocumentSnapshot>
                                              allDocuments = [
                                            ...geoDocuments,
                                            ...userDocuments
                                          ];

                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: allDocuments.length,
                                            itemBuilder: (context, index) {
                                              Map<String, dynamic> data =
                                                  allDocuments[index].data()
                                                      as Map<String, dynamic>;
                                              String questionId =
                                                  allDocuments[index].id;
                                              String questionText =
                                                  data['question'] as String;
                                              return Column(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 8,
                                                    ),
                                                    child: ListTile(
                                                      title: Text(
                                                        questionText,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                        textDirection:
                                                            TextDirection.rtl,
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    GeoChoices(
                                                              questionId:
                                                                  questionId,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const Divider(
                                                    thickness: 0,
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
