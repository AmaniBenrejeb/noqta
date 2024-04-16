
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

enum Language { Arabic, French }

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}
 
 
class _ResetPasswordState extends State<ResetPassword> {
  bool _isLoading = false;
  Language currentEmailLanguage = Language.Arabic;
  String? Emaill;
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
      body: Stack(
        children: [
          // resetPasswordBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Center(
                child: Text(
                  "إعادة تعيين كلمة السر",
                  textAlign: TextAlign.right,
                  style: GoogleFonts.montserratAlternates(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.022,
              ),
              Center(
                child: Text(
                  "استعيد حسابك عن طريق إعادة تعيين كلمة السر الخاصة بك",
                  textAlign: TextAlign.right,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.032,
              ),
              SizedBox(
                width: 330,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xFFF2E5FF)),
                    ),
                    child: Directionality(
                      textDirection: currentEmailLanguage == Language.Arabic
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.poppins(),
    
                          hintText: 'البريد الإلكتروني',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // counterText:
                          //     '*Please use a verified e-mail',
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return '';
                        //   } else {
                        //     setState(() {
                        //       Emaill = value;
                        //     });
                        //     return null;
                        //   }
                        // },
                        onChanged: (value) {
                          Emaill = value;
                          setState(() {
                            currentEmailLanguage = detectLanguage(value);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.032,
              ),
              Center(
                child: SizedBox(
                  width: screenWidth * 0.82,
                  height: screenHeight * 0.07,
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            resetPassword(Emaill.toString());
    
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            print('Email: $Emaill');
                          },
                          child: Text(
                            "إعادة تعيين كلمة السر",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFA779F7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void resetPassword(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(email: email);
      AnimatedSnackBar.material(
        ' تم إرسال رسالة إعادة تعيين كلمة السر',
        type: AnimatedSnackBarType.success,
        duration: Duration(seconds: 6),
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text('تم إرسال رسالة إعادة تعيين كلمة السر'),
      //       ],
      //     ),
      //   ),
      // );
    } catch (e, stackTrace) {
      print('Failed to send password reset email: $e');
      print('Stack trace: $stackTrace');
      AnimatedSnackBar.material(
        'فشل إعادة تعيين كلمة السر',
        type: AnimatedSnackBarType.error,
        duration: Duration(seconds: 6),
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text('فشل إعادة تعيين كلمة السر'),
      //       ],
      //     ),
      //   ),
      // );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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