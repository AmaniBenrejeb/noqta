import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:mypfe/homepage.dart';
import '../backgrounds/login.dart';
import 'createAccount.dart';
import '../additional/resetpassword.dart';


//import 'package:bubble/screens/history.dart';
//import 'package:bubble/screens/updateData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  String? email;
  String? f_name;
  String? password;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight, // Constrain the height of the Stack
          child: Stack(
            children: [
              loginBackground(),
              Positioned(
                top: screenHeight * 0.22,
                right: 60,
                left: 60,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.2),
                        Text(
                          "تسجيل الدخول",
                          selectionColor: Color(0xFF939393),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Container(
                          width: 218,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFEFE5FF),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextField(
                                  textAlign: TextAlign.right,
                                  cursorHeight: 25,
                                  decoration: InputDecoration(
                                    prefixIconConstraints: BoxConstraints(
                                        minHeight: 30, minWidth: 30),
                                    hintText: "البريد الإلكتروني",
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 163, 163, 163)
                                                .withOpacity(0.7)),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFAB9EC3)
                                              .withOpacity(0.7),
                                        ),
                                        child: Icon(
                                          Icons.mail_outline,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Container(
                          width: 218,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFEFE5FF),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextFormField(
                                  cursorHeight: 25,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: "كلمة السّر",
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 163, 163, 163)
                                                .withOpacity(0.7)),
                                    prefixIconConstraints: BoxConstraints(
                                        minHeight: 30, minWidth: 30),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFAB9EC3)
                                              .withOpacity(0.7),
                                        ),
                                        child: Icon(
                                          Icons.lock_outline,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  autofocus: false,
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    } else {
                                      setState(() {
                                        password = value;
                                      });
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration: Duration.zero,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ResetPassword()));
                          },
                          child: Text("نسيت كلمة السر؟ "),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFA779F7),
                          ),
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                email: email!.trim(),
                                password: password!.trim(),
                              );

                              User? user = FirebaseAuth.instance.currentUser;

                              // Fetch user data from Firestore
                              FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(user!.uid)
                                  .get()
                                  .then((DocumentSnapshot documentSnapshot) {
                                if (documentSnapshot.exists) {
                                  Map<String, dynamic> userData =
                                      documentSnapshot.data()
                                          as Map<String, dynamic>;
                                  String displayName =
                                      userData['full name'] ?? '';

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                               
                                    AnimatedSnackBar.material(
                                  ' متصل $displayName المستخدم',
                                  type: AnimatedSnackBarType.success,
                                  duration: Duration(seconds: 6),
                                  mobileSnackBarPosition:
                                      MobileSnackBarPosition.bottom,
                                ).show(context);
                                  
                                }
                              }).catchError((error) {
                                print("Failed to fetch user data: $error");
                              });
                            } on FirebaseAuthException catch (ex) {
                              print('FirebaseAuthException code: ${ex.code}');
                              if (ex.code == 'invalid-credential') {
                                AnimatedSnackBar.material(
                                  'البريد الإلكتروني أو كلمة المرور غير صحيحة',
                                  type: AnimatedSnackBarType.error,
                                  duration: Duration(seconds: 6),
                                  mobileSnackBarPosition:
                                      MobileSnackBarPosition.bottom,
                                ).show(context);
                                
                              } else if (ex.code == 'invalid-email') {
                                AnimatedSnackBar.material(
                                  'البريد الإلكتروني غير صالح',
                                  type: AnimatedSnackBarType.error,
                                  duration: Duration(seconds: 4),
                                  mobileSnackBarPosition:
                                      MobileSnackBarPosition.bottom,
                                ).show(context);
                              } else {
                                // Handle other FirebaseAuthException errors
                                AnimatedSnackBar.material(
                                  'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى لاحقًا.',
                                  type: AnimatedSnackBarType.error,
                                  duration: Duration(seconds: 4),
                                  mobileSnackBarPosition:
                                      MobileSnackBarPosition.bottom,
                                ).show(context);
                              }
                            }
                          },
                          child: Text(
                            "تسجيل الدخول ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => createAccount()),
                                );
                              },
                              child: Text(
                                "إنشاء حساب",
                                style: GoogleFonts.poppins(
                                  color: Color(0xFFA779F7),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              "ليس لديك حساب ؟",
                              style: GoogleFonts.poppins(
                                color: Color(0xFFBBB0B0),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.187,
                child: SimpleShadow(
                  child: Image.asset(
                    "images/braille.png",
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}