import 'package:flutter/material.dart';
import '../backgrounds/seet.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class history extends StatefulWidget {
  const history({super.key});

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
 User? _userr = FirebaseAuth.instance.currentUser;
    var _uid = _userr!.uid;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_right,
              size: 40,
            ),
          ),
        ],
        title: Text(
          "الإجابات",
          style: GoogleFonts.radioCanada(
            fontSize: 23,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
            settingsBackground(),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: Divider(
                height: 1,
                color: Color(0xFFF2E5FF),
              ),
            ),
StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('Users')
      .doc(_uid)
      .collection('historique')
      .snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    var documents = snapshot.data!.docs;
    return ListView.builder(
      itemCount: documents.length > 0 ? documents.length - 1 : 0,
      itemBuilder: (context, index) {
        var doc = documents[index+1];
        if (doc['question'] != "" && doc['reponse'] != "" &&doc['reponseValidation'] != "") {
          Color borderColor = doc['reponseValidation'] != 'false'  ? Colors.green : Colors.red;
          return Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 46,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Color(0xffF2E5FF),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              doc['question'],
                              style: GoogleFonts.radioCanada(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 46,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                       
                        border: Border.all(
                          width: 2,
                          color: borderColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              doc['reponse'],
                              style: GoogleFonts.radioCanada(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return SizedBox(); 
        }
      },
    );
  },
),


          ]),
        ),
      ),
    );
  }
}
