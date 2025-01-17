import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class AddHiQuestionModal extends StatefulWidget {
  const AddHiQuestionModal({super.key});

  @override
  State<AddHiQuestionModal> createState() => _AddHiQuestionModalState();
}

class _AddHiQuestionModalState extends State<AddHiQuestionModal> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController choice1Controller = TextEditingController();
  final TextEditingController choice2Controller = TextEditingController();
  final TextEditingController choice3Controller = TextEditingController();
  final TextEditingController correctAnswerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
               toolbarHeight: screenHeight * 0.11,
        backgroundColor: const Color(0xFFFED159),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 190),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              child: Text(
                'إضافة سؤال ',
                style: GoogleFonts.lateef(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 25,
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
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: questionController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: '*السؤال',
                hintStyle:
                    const TextStyle(fontSize: 15, color: Color.fromARGB(255, 191, 183, 199)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFFFED159)), // Set the desired border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFFF2E5FF)), // Set the desired border color
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: choice1Controller,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: '*الخيار1 ',
                hintStyle:
                    const TextStyle(fontSize: 15, color: Color.fromARGB(255, 191, 183, 199)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFFFED159)), // Set the desired border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFFF2E5FF)), // Set the desired border color
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: choice2Controller,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: '*الخيار2 ',
                hintStyle:
                    const TextStyle(fontSize: 15, color: Color.fromARGB(255, 191, 183, 199)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFFFED159)), // Set the desired border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFFF2E5FF)), // Set the desired border color
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: choice3Controller,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: '*الخيار3 ',
                hintStyle:
                    const TextStyle(fontSize: 15, color: Color.fromARGB(255, 191, 183, 199)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFFFED159)), // Set the desired border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFFF2E5FF)), // Set the desired border color
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: correctAnswerController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: '*الإجابة الصحيحة ',
                hintStyle:
                    const TextStyle(fontSize: 15, color: Color.fromARGB(255, 191, 183, 199)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFFFED159)), // Set the desired border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFFF2E5FF)), // Set the desired border color
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                addQuestionToDatabase();
                // Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFFED159)),
              ),
              child: const Text('حفظ',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400)
                      ),
            ),
          ],
        ),
      ),
    );
  }

  void addQuestionToDatabase() {
    if (questionController.text.isEmpty ||
        choice1Controller.text.isEmpty ||
        choice2Controller.text.isEmpty ||
        choice3Controller.text.isEmpty ||
        correctAnswerController.text.isEmpty) {
       AnimatedSnackBar.material(
        ' يرجى ملء جميع الحقول',
        type: AnimatedSnackBarType.info,
        duration: Duration(seconds: 6),
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
    } else {
      final User? user = FirebaseAuth.instance.currentUser;
      final String? userId = user?.uid;
    //  String userId ='amouna'; // Vous devez remplacer cela par la vraie ID de l'utilisateur
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('question_added_his')
          .add({
        'question': questionController.text,
        'correct_answer': correctAnswerController.text,
      }).then((docRef) {
        // Ajouter les choix dans la sous-collection 'choices'
        docRef.collection('choices').add({'answer': choice1Controller.text});
        docRef.collection('choices').add({'answer': choice2Controller.text});
        docRef.collection('choices').add({'answer': choice3Controller.text});
      }).catchError((error) {
        // Gérer les erreurs ici
        print('Erreur lors d ajout de la question: $error');
      });
      Navigator.pop(context);
    }
  }
}