import 'package:mypfe/homepage.dart';

import '../backgrounds/login.dart';
import 'package:mypfe/auth/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class createAccount extends StatefulWidget {
  const createAccount({Key? key});

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
  // bool _obscureText = true;
  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Scaffold(
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
                            "إنشاء حساب  ",
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
                                  child: TextFormField(
                                    textAlign: TextAlign.right,
                                    cursorHeight: 25,
                                    controller: _fNameController,
                                    decoration: InputDecoration(
                                      prefixIconConstraints: BoxConstraints(
                                          minHeight: 30, minWidth: 30),
                                      hintText: " إسم المستخدم",
                                      hintStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 163, 163, 163)
                                                  .withOpacity(0.7)),
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFAB9EC3)
                                                .withOpacity(0.7),
                                          ),
                                          child: Icon(
                                            Icons.person_outline_outlined,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    autofocus: false,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your full name';
                                      } else {
                                        setState(() {
                                          f_name = value;
                                        });
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      f_name = value;
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
                                    controller: _emailController,
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
                                        padding:
                                            const EdgeInsets.only(right: 8),
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      } else {
                                        setState(() {
                                          email = value;
                                        });
                                        return null;
                                      }
                                    },
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
                                    controller: _passwordController,
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
                                        padding:
                                            const EdgeInsets.only(right: 8),
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
                                    onChanged: (value) {
                                      password = value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.035),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFA779F7),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  QuerySnapshot querySnapshot =
                                      await FirebaseFirestore.instance
                                          .collection('Users')
                                          .where('email',
                                              isEqualTo: email!.trim())
                                          .get();

                                  if (querySnapshot.docs.isNotEmpty) {
                                    // Email address already exists, show error message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Color(0xFFA779F7),
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                'هذا البريد الإلكتروني مستخدم بالفعل'),
                                          ],
                                        ),
                                      ),
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
                                    await FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(_uid)
                                        .collection('historique')
                                        .add({});

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Color(0xFFA779F7),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '"بنجاح $f_name تم إنشاءحساب باسم "',
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Color(0xFFA779F7),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('كلمة السر غير صالحة '),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else if (e.code == 'invalid-email') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Color(0xFFA779F7),
                                        content: Center(
                                            child: Text(
                                          'البريد الإلكتروني غير صالح',
                                        )),
                                      ),
                                    );
                                  }
                                }
                              }
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
      ),
    );
  }
}