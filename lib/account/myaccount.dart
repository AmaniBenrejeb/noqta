import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypfe/account/answers.dart';
import 'package:mypfe/btm_nav_bar.dart';
import 'package:mypfe/account/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mypfe/auth/login_screen.dart';

class MyAcc extends StatefulWidget {
  const MyAcc({super.key});

  @override
  State<MyAcc> createState() => _MyAccState();
}

class _MyAccState extends State<MyAcc> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFC6B0EE),
          ),
          Positioned(
            top: screenHeight * 0.15,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  buildRow(context, "images/answer.png", "الإجابات",
                      Icons.arrow_back_ios_new_rounded),
                  const SizedBox(height: 20),
                  const SizedBox(
                      width: 360, child: Divider(color: Color(0xFFF2E5FF))),
                  const SizedBox(height: 20),
                  buildRow(context, "images/setting.png", "الإعدادات",
                      Icons.arrow_back_ios_new_rounded),
                  const SizedBox(height: 20),
                  const SizedBox(
                      width: 360, child: Divider(color: Color(0xFFF2E5FF))),
                  const SizedBox(height: 20),
                  buildRow(context, "images/logout.png", "خروج",
                      Icons.arrow_back_ios_new_rounded),
                  const SizedBox(height: 20),
                  const SizedBox(
                      width: 360, child: Divider(color: Color(0xFFF2E5FF))),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width:
                        110, // Adjust this to set the total size including the border
                    height:
                        110, // Adjust this to set the total size including the border
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      "images/person.png",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget buildRow(
      BuildContext context, String imagePath, String text, IconData icon) {
    return GestureDetector(
        onTap: () {
          if (imagePath == "images/answer.png") {
            // Navigate to the page for "الإجابات" (Answers)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const history()),
            );
          } else if (imagePath == "images/setting.png") {
            // Navigate to the page for "الإعدادات" (Settings)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UpdateData()),
            );
          } else if (imagePath == "images/logout.png") {
            //  "خروج" (Logout)
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Login_screen())); // Redirection vers l'écran de connexion
          }
        },
        child: SizedBox(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: const Color(0xFFF2E5FF),
                ),
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
                Image.asset(imagePath, width: 25, height: 25),
              ],
            )));
  }
}
