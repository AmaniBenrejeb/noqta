import 'package:flutter/material.dart';


import 'package:mypfe/homepage.dart';
import 'package:mypfe/math/addquestions.dart';
import 'package:mypfe/math/mathchoices.dart';
import 'package:mypfe/math/mathquestions.dart';


import 'package:mypfe/science/sciencequestions.dart';
import 'package:mypfe/geo/geoquestions.dart';
import 'package:mypfe/history/historyquestions.dart';
import 'package:mypfe/din/dinquestions.dart';
import 'package:mypfe/myaccount.dart';
import 'package:mypfe/answers.dart';
import 'package:mypfe/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        initialRoute: "/home",
        routes: {
          "/home": (context) => const HomePage(),
          "/math": (context) => const MathQu(),
          "/science":(context) => const ScQu(),
          "/geo":(context) => const GeoQu(),
          "/history":(context) => const HiQu(),
          "/din":(context) => const DinQu(),
          "/acc":(context) => const MyAcc(),
          "/answ":(context) => const MyAnswers(),
          "/set":(context) => const MySettings(),
          "/chmath":(context) => const MathChoices(questionId:"YourQuestionIdHere" ),
          "/addmath":(context) => const AddQuestionModal(),
          
          
    



          
          
          


          
          
        });
  }
}
