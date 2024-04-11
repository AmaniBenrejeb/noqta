import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddDinQuestionModal extends StatefulWidget {
  const AddDinQuestionModal({super.key});

  @override
  State<AddDinQuestionModal> createState() => _AddDinQuestionModalState();
}

class _AddDinQuestionModalState extends State<AddDinQuestionModal> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController choice1Controller = TextEditingController();
  final TextEditingController choice2Controller = TextEditingController();
  final TextEditingController choice3Controller = TextEditingController();
  final TextEditingController correctAnswerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF187F5B),
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
                    const TextStyle(fontSize: 15, color: Color(0xFFF2E5FF)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFF187F5B)), // Set the desired border color
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
                    const TextStyle(fontSize: 15, color: Color(0xFFF2E5FF)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFF187F5B)), // Set the desired border color
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
                    const TextStyle(fontSize: 15, color: Color(0xFFF2E5FF)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFF187F5B)), // Set the desired border color
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
                    const TextStyle(fontSize: 15, color: Color(0xFFF2E5FF)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFF187F5B)), // Set the desired border color
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
                    const TextStyle(fontSize: 15, color: Color(0xFFF2E5FF)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Color(0xFF187F5B)), // Set the desired border color
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
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF187F5B)),
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: const Text('يجب إكمال جميع الحقول'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      final User? user = FirebaseAuth.instance.currentUser;
      final String? userId = user?.uid;
    //  String userId ='amouna'; // Vous devez remplacer cela par la vraie ID de l'utilisateur
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('question_added_din')
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
    }
  }
}
