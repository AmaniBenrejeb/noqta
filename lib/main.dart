import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:mypfe/BluetoothProvider.dart';
import 'package:mypfe/homepage.dart';
import 'package:mypfe/subjects/math/add_ma_questions.dart';
import 'package:mypfe/subjects/math/mathchoices.dart';
import 'package:mypfe/subjects/math/mathquestions.dart';
import 'package:mypfe/subjects/science/sciencequestions.dart';
import 'package:mypfe/subjects/geo/geoquestions.dart';
import 'package:mypfe/subjects/history/historyquestions.dart';
import 'package:mypfe/subjects/din/dinquestions.dart';
import 'package:mypfe/account/myaccount.dart';
import 'package:mypfe/account/answers.dart';
import 'package:mypfe/account/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mypfe/auth/login_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
User? user = FirebaseAuth.instance.currentUser;
  Widget initialScreen = user != null ? HomePage() : Login_screen();

  runApp(
     MultiProvider(
     providers: [
        ChangeNotifierProvider(create: (_) => BluetoothProvider(FlutterBlue.instance)),
      ],

    child: MyApp(initialScreen: initialScreen)));
}


class MyApp extends StatelessWidget {
   final Widget initialScreen;
  const MyApp({Key? key, required this.initialScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BluetoothProvider(FlutterBlue.instance),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        home: initialScreen,
        routes: {
          "/home": (context) => const HomePage(),
          "/math": (context) => const MathQu(),
          "/science":(context) => const ScQu(),
          "/geo":(context) => const GeoQu(),
          "/history":(context) => const HiQu(),
          "/din":(context) => const DinQu(),
          "/acc":(context) => const MyAcc(),
          "/answ":(context) => const history(),
          "/set":(context) => const UpdateData(),
          "/chmath":(context) => const MathChoices(questionId:"YourQuestionIdHere" ),
          "/addmath":(context) => const AddQuestionModal(),  
          "/login":(context) => const Login_screen(), 
        },
      ),
    );
  }
}