import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:mypfe/homepage.dart';
import '../backgrounds/login.dart';
import 'createAccount.dart';
import '../additional/resetpassword.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Language { Arabic, French }

class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  String? email;
  String? f_name;
  String? password;
  bool _obscurePassword = true;
  bool _isLoading = false;
  TextEditingController _controller = TextEditingController();
  Language currentEmailLanguage = Language.Arabic;
  Language currentPasswordLanguage = Language.Arabic;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
          height: screenHeight,
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
                        Center(
                          child: Text(
                            "تسجيل الدخول",
                            style:GoogleFonts.amiri(textStyle:TextStyle(fontSize: 20), color: Color.fromARGB(255, 59, 53, 53)),
                            
                          ),
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
                            padding: EdgeInsets.only(left: 10),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Directionality(
                                  textDirection:
                                      currentEmailLanguage == Language.Arabic
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                  child: TextFormField(
                                    controller: _controller,
                                    cursorHeight: 25,
                                    decoration: InputDecoration(
                                      hintText: "البريد الإلكتروني",
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 163, 163, 163)
                                                  .withOpacity(0.7)),
                                      contentPadding: EdgeInsets.only(
                                          left: 8, top: 8, bottom: 8),
                                      suffixIcon: Icon(
                                        Icons.mail_outline,
                                        color:
                                            Color.fromARGB(255, 149, 124, 173),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    autofocus: false,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return null;
                                      } else {
                                        setState(() {
                                          email = value;
                                        });
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      email = value;
                                      setState(() {
                                        currentEmailLanguage =
                                            detectLanguage(value);
                                      });
                                    },
                                  ),
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
                            padding: const EdgeInsets.only(left: 10),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Directionality(
                                  textDirection:
                                      currentPasswordLanguage == Language.Arabic
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                  child: TextFormField(
                                    cursorHeight: 25,
                                    obscureText: _obscurePassword,
                                    decoration: InputDecoration(
                                      hintText: "كلمة السّر",
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 163, 163, 163)
                                                  .withOpacity(0.7)),
                                      contentPadding: EdgeInsets.only(
                                          left: 10, top: 10, bottom: 10),
                                      suffixIcon: IconButton(
                                        icon: Icon(_obscurePassword
                                            ? Icons.lock_outline
                                            : Icons.lock_open_outlined),
                                        color:
                                            Color.fromARGB(255, 149, 124, 173),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    autofocus: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return null; // Return null without any message
                                      } else {
                                        setState(() {
                                          email = value;
                                        });
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      password = value;
                                      setState(() {
                                        currentPasswordLanguage =
                                            detectLanguage(value);
                                      });
                                    },
                                  ),
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
                        _isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFA779F7),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if (email == null ||
                                      email!.isEmpty ||
                                      password == null ||
                                      password!.isEmpty) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    AnimatedSnackBar.material(
                                      'يرجى ملء جميع المعلومات الشخصية',
                                      type: AnimatedSnackBarType.info,
                                      duration: Duration(seconds: 6),
                                      mobileSnackBarPosition:
                                          MobileSnackBarPosition.bottom,
                                    ).show(context);
                                    return;
                                  }
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: email!.trim(),
                                      password: password!.trim(),
                                    );

                                    User? user =
                                        FirebaseAuth.instance.currentUser;

                                    // Fetch user data from Firestore
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(user!.uid)
                                        .get()
                                        .then((DocumentSnapshot
                                            documentSnapshot) async {
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
                                      print(
                                          "Failed to fetch user data: $error");
                                    });
                                  } on FirebaseAuthException catch (ex) {
                                    print(
                                        'FirebaseAuthException code: ${ex.code}');
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
                                  setState(() {
                                    _isLoading = false;
                                  });
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
                top: screenHeight * 0.1,
                left: screenWidth * 0.19,
                child: SimpleShadow(
                  child: Image.asset(
                    "images/braille.png",
                    width: screenWidth * 0.58,
                    height: screenHeight * 0.29,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Language detectLanguage(String text) {
    // Example language detection logic
    if (text.contains(RegExp(r'[a-zA-Z]'))) {
      return Language.French;
    } else {
      return Language.Arabic;
    }
  }
}