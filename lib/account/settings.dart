import '../backgrounds/seet.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Language { Arabic, French }

class UpdateData extends StatefulWidget {
  const UpdateData({Key? key}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  String? email;
  String? f_name;
  String? password;
  bool _obscurePassword = true;
  bool _obscurePassword1 = true;
  bool _isLoading = false;
  Language currentNameLanguage = Language.Arabic;
  Language currentEmailLanguage = Language.Arabic;
  Language currentPasswordLanguage = Language.Arabic;
  Language currentNewPasswordLanguage = Language.Arabic;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: screenHeight * 0.1,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_right,
              size: 40,
            ),
          ),
        ],
        title: Text(
          "الإعدادات",
          style: GoogleFonts.radioCanada(
            fontSize: 23,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              settingsBackground(),
              Positioned(
               top: screenHeight * 0.14,
                left: 0,
                right: 0,
                child: Divider(
                  height: 1,
                  color: Color(0xFFF2E5FF),
                ),
              ),
              Column(children: [
                SizedBox(height: screenHeight * 0.2),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("إسم المستخدم الجديد",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.radioCanada(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: screenHeight * 0.053,
                        width: screenWidth * 0.9,
                    child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Directionality(
                            textDirection:
                                currentNameLanguage == Language.Arabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            child: TextFormField(
                              controller: _usernameController,
                              style: GoogleFonts.radioCanada(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: " إسم المستخدم الجديدة",
                                hintStyle: GoogleFonts.radioCanada(
                                    color: Color(0xFFF2E5FF),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: Color(
                                        0xFFF2E5FF), // Color of the border when not focused
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: Color(
                                        0xFFF2E5FF), // Color of the border when focused
                                  ),
                                ),
                                suffixIcon: Icon(Icons.person_outline_outlined,
                                    color: Color.fromARGB(255, 149, 124, 173)),
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
                                setState(() {
                                  f_name = value;
                                  setState(() {
                                    currentNameLanguage = detectLanguage(value);
                                  });
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(" البريد الإلكتروني الجديد",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.radioCanada(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                      height: screenHeight * 0.053,
                        width: screenWidth * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Directionality(
                            textDirection:
                                currentEmailLanguage == Language.Arabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            child: TextFormField(
                              controller: _emailController,
                              style: GoogleFonts.radioCanada(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: "  البريد الإلكتروني الجديد",
                                hintStyle: GoogleFonts.radioCanada(
                                    color: Color(0xFFF2E5FF),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: Color(
                                        0xFFF2E5FF), // Color of the border when not focused
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: Color(
                                        0xFFF2E5FF), // Color of the border when focused
                                  ),
                                ),
                                suffixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color.fromARGB(255, 149, 124, 173),
                                ),
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
                                setState(() {
                                  currentEmailLanguage = detectLanguage(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("كلمة السر الحالية",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.radioCanada(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: screenHeight * 0.053,
                        width: screenWidth * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Directionality(
                            textDirection:
                                currentPasswordLanguage == Language.Arabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            child: TextFormField(
                              controller: _currentPasswordController,
                              obscureText: _obscurePassword1, // Password field
                              style: GoogleFonts.radioCanada(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: "كلمة السر الحالية",
                                hintStyle: GoogleFonts.radioCanada(
                                    color: Color(0xFFF2E5FF),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF2E5FF),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF2E5FF),
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscurePassword1
                                      ? Icons.lock_outline
                                      : Icons.lock_open_outlined),
                                  color: Color.fromARGB(255, 149, 124, 173),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword1 =
                                          !_obscurePassword1; // Toggle visibility
                                    });
                                  },
                                ),
                              ),
                              autofocus: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter current password';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  currentPasswordLanguage =
                                      detectLanguage(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("كلمة السر الجديدة    ",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.radioCanada(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                       height: screenHeight * 0.053,
                        width: screenWidth * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Directionality(
                            textDirection:
                                currentNewPasswordLanguage == Language.Arabic
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: GoogleFonts.radioCanada(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: " كلمة السر الجديدة  ",
                                hintStyle: GoogleFonts.radioCanada(
                                    color: Color(0xFFF2E5FF),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: Color(
                                        0xFFF2E5FF), // Color of the border when not focused
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: Color(
                                        0xFFF2E5FF), // Color of the border when focused
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscurePassword
                                      ? Icons.lock_outline
                                      : Icons.lock_open_outlined),
                                  color: Color.fromARGB(255, 149, 124, 173),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword =
                                          !_obscurePassword; // Toggle visibility
                                    });
                                  },
                                ),
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
                                setState(() {
                                  currentNewPasswordLanguage =
                                      detectLanguage(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.18),
                //condition ? expression1 : expression2
                _isLoading
                    ? CircularProgressIndicator()
                    : Container(width: screenWidth*0.9,
  padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(320, 50),
                            backgroundColor: Color(0xFFA779F7),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            User? user = FirebaseAuth.instance.currentUser;
                      
                            if (user != null) {
                              if (_usernameController.text.isEmpty ||
                                  _emailController.text.isEmpty ||
                                  _passwordController.text.isEmpty ||
                                  _currentPasswordController.text.isEmpty) {
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
                                AuthCredential credential =
                                    EmailAuthProvider.credential(
                                        email: user.email!,
                                        password:
                                            _currentPasswordController.text);
                                await user
                                    .reauthenticateWithCredential(credential);
                                await user.verifyBeforeUpdateEmail(
                                    _emailController.text);
                                await user
                                    .updatePassword(_passwordController.text);
                                await user
                                    .updateDisplayName(_usernameController.text);
                      
                                Map<String, dynamic> updatedData = {
                                  "full name": _usernameController.text,
                                  "email": _emailController.text,
                                };
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(user.uid)
                                    .update(updatedData)
                                    .then((_) {
                                  AnimatedSnackBar.material(
                                    'تم تحديث البيانات بنجاح',
                                    type: AnimatedSnackBarType.success,
                                    duration: Duration(seconds: 6),
                                    mobileSnackBarPosition:
                                        MobileSnackBarPosition.bottom,
                                  ).show(context);
                                }).catchError((error) {
                                  AnimatedSnackBar.material(
                                    'فشل تحديث البيانات',
                                    type: AnimatedSnackBarType.error,
                                    duration: Duration(seconds: 6),
                                    mobileSnackBarPosition:
                                        MobileSnackBarPosition.bottom,
                                  ).show(context);
                                });
                              } catch (e) {
                                print('Error updating password: $e');
                                AnimatedSnackBar.material(
                                  'فشل تحديث كلمة المرور',
                                  type: AnimatedSnackBarType.error,
                                  duration: Duration(seconds: 6),
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
                            "حفظ  ",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.radioCanada(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ),
              ]),
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