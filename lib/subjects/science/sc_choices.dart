import 'dart:convert';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mypfe/BluetoothProvider.dart';
import 'package:provider/provider.dart';

class ScChoices extends StatefulWidget {
  final String questionId;
  final Key? key;

  const ScChoices({required this.questionId, this.key}) : super(key: key);

  @override
  _ScChoicesState createState() => _ScChoicesState();
}

class _ScChoicesState extends State<ScChoices> {
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

    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid;

    final scSnapshot = await FirebaseFirestore.instance
        .collection('Science')
        .doc(widget.questionId)
        .get();
    if (scSnapshot.exists) {
      _questionStream = FirebaseFirestore.instance
          .collection('Science')
          .doc(widget.questionId)
          .snapshots();
      _choicesStream = FirebaseFirestore.instance
          .collection('Science')
          .doc(widget.questionId)
          .collection('choices')
          .snapshots();
    } else {
      _questionStream = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('question_added_Sc')
          .doc(widget.questionId)
          .snapshots();
      _choicesStream = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('question_added_Sc')
          .doc(widget.questionId)
          .collection('choices')
          .snapshots();
    }
  }
  //
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
        backgroundColor: const Color(0xFF79C5F7),
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
                  border: Border.all(color: const Color(0xFF79C5F7)),
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
                          var choices = snapshot.data!.docs
                              .map((doc) => doc.data()['answer'] as String)
                              .toList();
                          // Store choices in the _choices variable
                          _choices = choices; // 

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
                        String? userId = FirebaseAuth.instance.currentUser?.uid;
                        if (userId != null) {
                          DocumentSnapshot<Map<String, dynamic>>
                              questionSnapshot;
                          var questionData;
                          String question = '';
                          List<String> choices = [];

                          var dinQuestionSnapshot = await FirebaseFirestore
                              .instance
                              .collection('Science')
                              .doc(widget.questionId)
                              .get();
                          if (dinQuestionSnapshot.exists) {
                            questionSnapshot = dinQuestionSnapshot;
                          } else {
                            questionSnapshot = await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(userId)
                                .collection('question_added_Sc')
                                .doc(widget.questionId)
                                .get();
                          }

                          if (questionSnapshot.exists) {
                            questionData = questionSnapshot.data();
                            question = questionData?['question'] ?? '';
                          }

                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(userId)
                              .collection('historique')
                              .add({
                            'question': question,
                            'response': '',
                            'responseValidation': '',
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

                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF79C5F7)),
                      ),
                      child: const Text(
                        'إرسال',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
