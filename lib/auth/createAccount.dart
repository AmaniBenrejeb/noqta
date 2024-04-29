import 'package:mypfe/homepage.dart';
import '../backgrounds/login.dart';
import 'package:mypfe/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

enum Language { Arabic, French }

class createAccount extends StatefulWidget {
  const createAccount({Key? key}) : super(key: key);


  @override
  State<createAccount> createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  // bool _acceptedTerms = false;
  String? email;
  String? f_name;
  String? password;
  var _fNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;
  Language currentNameLanguage = Language.Arabic;
  Language currentEmailLanguage = Language.Arabic;
  Language currentPasswordLanguage = Language.Arabic;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
           
            
               IconButton(
                icon: Image.asset(
                  'images/next.png',
                  width: 30,
                  height: 30,
                  color: Color.fromARGB(255, 222, 218, 224)
                
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            
          ],
        ),
          automaticallyImplyLeading: false,
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
                            "إنشاء حساب  ",
                            style:GoogleFonts.amiri(textStyle:TextStyle(fontSize: 20), color: Color.fromARGB(255, 59, 53, 53)),
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
                                        currentNameLanguage == Language.Arabic
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                                    child: TextFormField(
                                      cursorHeight: 25,
                                      controller: _fNameController,
                                      decoration: InputDecoration(
                                        prefixIconConstraints: BoxConstraints(
                                            minHeight: 30, minWidth: 30),
                                        hintText: " إسم المستخدم",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                    255, 163, 163, 163)
                                                .withOpacity(0.7)),
                                        contentPadding: EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        suffixIcon: Icon(
                                          Icons.person_outline_outlined,
                                          color: Color.fromARGB(
                                              255, 149, 124, 173),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return null;
                                        } else {
                                          setState(() {
                                            f_name = value;
                                          });
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        f_name = value;
                                        setState(() {
                                          currentNameLanguage =
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
                                      controller: _emailController,
                                      cursorHeight: 25,
                                      decoration: InputDecoration(
                                        prefixIconConstraints: BoxConstraints(
                                            minHeight: 30, minWidth: 30),
                                        hintText: "البريد الإلكتروني",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                    255, 163, 163, 163)
                                                .withOpacity(0.7)),
                                        contentPadding: EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        suffixIcon: Icon(
                                          Icons.mail_outline,
                                          color: Color.fromARGB(
                                              255, 149, 124, 173),
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
                              padding: EdgeInsets.only(left: 10),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Directionality(
                                    textDirection: currentPasswordLanguage ==
                                            Language.Arabic
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    child: TextFormField(
                                      controller: _passwordController,
                                      cursorHeight: 25,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                        hintText: "كلمة السّر",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                    255, 163, 163, 163)
                                                .withOpacity(0.7)),
                                        contentPadding: EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscurePassword
                                              ? Icons.lock_outline
                                              : Icons.lock_open_outlined),
                                          color: Color.fromARGB(
                                              255, 149, 124, 173),
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
                                          return null;
                                        } else {
                                          setState(() {
                                            password = value;
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
                          SizedBox(height: screenHeight * 0.035),
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
                                        password!.isEmpty ||
                                        f_name == null ||
                                        f_name!.isEmpty) {
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
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        QuerySnapshot querySnapshot =
                                            await FirebaseFirestore.instance
                                                .collection('Users')
                                                .where('email',
                                                    isEqualTo: email!.trim())
                                                .get();

                                        if (querySnapshot.docs.isNotEmpty) {
                                          AnimatedSnackBar.material(
                                            ' هذا البريد الإلكتروني مستخدم بالفعل',
                                            type: AnimatedSnackBarType.info,
                                            duration: Duration(seconds: 6),
                                            mobileSnackBarPosition:
                                                MobileSnackBarPosition.bottom,
                                          // ).show(context);
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(
                                          //   SnackBar(
                                          //     backgroundColor:
                                          //         Color(0xFFA779F7),
                                          //     content: Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.center,
                                          //       children: [
                                          //         Text(
                                          //             'هذا البريد الإلكتروني مستخدم بالفعل'),
                                          //       ],
                                          //     ),
                                          //   ),
                                          );
                                        } else {
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: email!.trim(),
                                                  password: password!.trim());

                                          final User? user =
                                              FirebaseAuth.instance.currentUser;
                                          final _uid = user!.uid;
                                          await FirebaseFirestore.instance
                                              .collection('Users')
                                              .doc(_uid)
                                              .set({
                                            "full name": "$f_name",
                                            "email": "$email",
                                            "id": _uid,
                                            "isAdmin": "false",
                                          });

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomePage(),
                                            ),
                                          );
                                          AnimatedSnackBar.material(
                                            ' بنجاح $f_name تم إنشاءحساب باسم ',
                                            type: AnimatedSnackBarType.success,
                                            duration: Duration(seconds: 6),
                                            mobileSnackBarPosition:
                                                MobileSnackBarPosition.bottom,
                                          ).show(context);
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   SnackBar(
                                          //     backgroundColor: Color(0xFFA779F7),
                                          //     content: Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.center,
                                          //       children: [
                                          //         Text(
                                          //           'بنجاح $f_name تم إنشاءحساب باسم ',
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // );
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          AnimatedSnackBar.material(
                                            ' كلمة السر غير صالحة ',
                                            type: AnimatedSnackBarType.error,
                                            duration: Duration(seconds: 6),
                                            mobileSnackBarPosition:
                                                MobileSnackBarPosition.bottom,
                                          ).show(context);
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   SnackBar(
                                          //     backgroundColor: Color(0xFFA779F7),
                                          //     content: Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.center,
                                          //       children: [
                                          //         Text('كلمة السر غير صالحة '),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // );
                                        } else if (e.code == 'invalid-email') {
                                          AnimatedSnackBar.material(
                                            ' البريد الإلكتروني غير صالح',
                                            type: AnimatedSnackBarType.error,
                                            duration: Duration(seconds: 6),
                                            mobileSnackBarPosition:
                                                MobileSnackBarPosition.bottom,
                                          ).show(context);
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   SnackBar(
                                          //     backgroundColor: Color(0xFFA779F7),
                                          //     content: Center(
                                          //         child: Text(
                                          //       'البريد الإلكتروني غير صالح',
                                          //     )),
                                          //   ),
                                          // );
                                        }
                                      }
                                    }
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                  child: Text(
                                    "إنشاء حساب ",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          SizedBox(height: screenHeight * 0.038),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login_screen()),
                                  );
                                },
                                child: Text(
                                  "         تسجيل الدخول ",
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFFA779F7),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Text(
                                "لديك حساب ؟",
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
                  left: screenWidth * 0.21,
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