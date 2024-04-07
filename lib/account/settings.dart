import '../backgrounds/seet.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({Key? key}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? email;
  String? f_name;
  String? password;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
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
                top: 120,
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
                      Text("إسم المستخدم",
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
                        height: 46,
                        width: 370,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            controller: _usernameController,
                            style: GoogleFonts.radioCanada(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: "إسم المستخدم",
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
                              });
                            },
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
                      Text("البريد الإلكتروني ",
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
                        height: 46,
                        width: 370,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            controller: _emailController,
                            style: GoogleFonts.radioCanada(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: "البريد الإلكتروني ",
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
                            },
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
                      Text("كلمة السر    ",
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
                        height: 46,
                        width: 370,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            controller: _passwordController,
                            style: GoogleFonts.radioCanada(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              hintText: "كلمة السر   ",
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
                              suffixIcon: Icon(Icons.lock_outline,
                                  color: Color.fromARGB(255, 149, 124, 173)),
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
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.3),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(320, 50),
                    backgroundColor: Color(0xFFA779F7),
                  ),
                  onPressed: () async {
                    User? user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      if (_usernameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        AnimatedSnackBar.material(
                          'يرجى ملء جميع المعلومات الشخصية',
                          type: AnimatedSnackBarType.info,
                          duration: Duration(seconds: 6),
                          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                        ).show(context);
                      }

                      try {
                        AuthCredential credential =
                            EmailAuthProvider.credential(
                                email: user.email!,
                                password: _passwordController.text);
                        await user.reauthenticateWithCredential(credential);
                        await user
                            .verifyBeforeUpdateEmail(_emailController.text);
                        await user.updatePassword(_passwordController.text);
                        await user.updateDisplayName(_usernameController.text);

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
                        AnimatedSnackBar.material(
                          'فشل تحديث كلمة المرور',
                          type: AnimatedSnackBarType.error,
                          duration: Duration(seconds: 6),
                          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                        ).show(context);
                      }
                    }
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
              ]),
            ],
          ),
        ),
      ),
    );
  }
}