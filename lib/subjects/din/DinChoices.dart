import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mypfe/BluetoothProvider.dart';
import 'package:provider/provider.dart';

class DinChoices extends StatefulWidget {
  final String questionId;
  final Key? key;

  const DinChoices({required this.questionId, this.key}) : super(key: key);

  @override
  _DinChoicesState createState() => _DinChoicesState();
}

class _DinChoicesState extends State<DinChoices> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _questionStream;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _choicesStream;
  late BluetoothProvider _bluetoothProvider; //
  // cette ligne pour déclarer _choices
  late List<String> _choices;

  late Future<void> _initializeStreams;

  @override
  void initState() {
    super.initState();
    _initializeStreams = _initializeData();
  }

  Future<void> _initializeData() async {
    _bluetoothProvider = Provider.of<BluetoothProvider>(context, listen: false);
    // Récupérer l'ID de l'utilisateur actuellement connecté
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid;

    // Définir manuellement l'identifiant de l'utilisateur
    //String userId = 'amouna';

    // Vérifier l'existence de la question dans la collection 'Din'
    final dinSnapshot = await FirebaseFirestore.instance
        .collection('Din')
        .doc(widget.questionId)
        .get();
    if (dinSnapshot.exists) {
      // Si la question existe dans la collection 'Din'
      _questionStream = FirebaseFirestore.instance
          .collection('Din')
          .doc(widget.questionId)
          .snapshots();
      _choicesStream = FirebaseFirestore.instance
          .collection('Din')
          .doc(widget.questionId)
          .collection('choices')
          .snapshots();
    } else {
      // Si la question n'existe pas dans la collection 'Din', la chercher dans la collection 'Users'
      _questionStream = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('question_added_din')
          .doc(widget.questionId)
          .snapshots();
      _choicesStream = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('question_added_din')
          .doc(widget.questionId)
          .collection('choices')
          .snapshots();
    }
  }

  Future<void> sendMessageToESP32(String question, List<String> choices) async {
    try {
      var message = {
        'question': question,
        'choices': choices,
      };
      await _bluetoothProvider.sendMessage(message);
    } catch (e) {
      print('Error sending message to ESP32: $e');
    }
  }

  Future<String> waitForReceiptFromESP32() async {
    return 'ReceiptReceived';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF187F5B),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
      body: FutureBuilder(
        future: _initializeStreams,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Container(
                height: 450,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFF187F5B)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: _questionStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.data() == null) {
                          return const Center(
                            child: Text('No question available'),
                          );
                        } else {
                          var questionData = snapshot.data!.data()!;
                          var question = questionData['question'] as String;

                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              question,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                      },
                    ),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: _choicesStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('No choices available'),
                          );
                        } else {
                          // Extract choices from snapshot and store them in a list of strings
                          List<String> choices = snapshot.data!.docs
                              .map((doc) => doc['answer'] as String)
                              .toList();

                          // Store choices in the _choices variable
                          _choices = choices;

                          return Column(
                            children: choices.map((choice) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: ListTile(
                                  title: Text(
                                    choice,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Create a new document in the 'historique' collection
                        String? userId = FirebaseAuth.instance.currentUser?.uid;
                        if (userId != null) {
                          DocumentSnapshot<Map<String, dynamic>>
                              questionSnapshot;
                          var questionData;
                          String question = '';

                          // Check if the question exists in the 'Din' collection
                          var dinQuestionSnapshot = await FirebaseFirestore
                              .instance
                              .collection('Din')
                              .doc(widget.questionId)
                              .get();
                          if (dinQuestionSnapshot.exists) {
                            questionSnapshot = dinQuestionSnapshot;
                          } else {
                            // Check if the question exists in the 'question_added_din' collection under the user
                            questionSnapshot = await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(userId)
                                .collection('question_added_din')
                                .doc(widget.questionId)
                                .get();
                          }

                          if (questionSnapshot.exists) {
                            questionData = questionSnapshot.data();
                            question = questionData?['question'] ?? '';
                          }

                          // Add the question to the 'historique' collection
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(userId)
                              .collection('historique')
                              .add({
                            'question': question,
                            'response': '', // Set empty response initially
                            'responseValidation':
                                '', // Set empty response validation initially
                          });

                          await sendMessageToESP32(question, _choices);

                          String receipt = await waitForReceiptFromESP32();

                          if (receipt == "ReceiptReceived") {
                            AnimatedSnackBar.material(
                              '!تم الإرسال بنجاح',
                              type: AnimatedSnackBarType.success,
                              duration: Duration(seconds: 4),
                              mobileSnackBarPosition:
                                  MobileSnackBarPosition.bottom,
                            ).show(context);
                          }

                          // Navigate back after adding the question to historique
                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF187F5B)),
                      ),
                      child: const Text('إرسال',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
