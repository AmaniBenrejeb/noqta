import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mypfe/BluetoothProvider.dart';
import 'package:mypfe/account/answers.dart';
import 'package:mypfe/btm_nav_bar.dart';
import 'package:mypfe/account/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mypfe/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAcc extends StatefulWidget {
  const MyAcc({Key? key}) : super(key: key);

  @override
  State<MyAcc> createState() => _MyAccState();
}

class _MyAccState extends State<MyAcc> {
  late ImagePicker _imagePicker;
  File? _selectedImage;
  String? _selectedImagePath; // Chemin de l'image sélectionnée

  void disconnectFromDevice() {
    final bluetoothProvider = Provider.of<BluetoothProvider>(context, listen: false);
    bluetoothProvider.disconnectFromDevice();
  }

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _loadSelectedImage(); // Charger l'image précédemment sélectionnée lors de l'initialisation de l'état
  }

  Future<void> _loadSelectedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedImagePath = prefs.getString('selectedImagePath') ?? null;
      _selectedImage = _selectedImagePath != null ? File(_selectedImagePath!) : null;
    });
  }

  Future<void> _openGallery() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _selectedImagePath = pickedFile.path; // Enregistrer le chemin de l'image sélectionnée
      });
      _saveSelectedImage(); // Enregistrer le chemin de l'image sélectionnée dans les préférences partagées
    }
  }

  Future<void> _saveSelectedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedImagePath', _selectedImagePath ?? ''); // Enregistrer le chemin de l'image
  }

  Future<void> _clearSelectedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedImagePath'); // Supprimer le chemin de l'image sélectionnée
    setState(() {
      _selectedImage = null; // Réinitialiser l'image sélectionnée à null
    });
  }

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
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
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
                  buildRow(context, "images/answer.png", "الإجابات", Icons.arrow_back_ios_new_rounded),
                  const SizedBox(height: 20),
                  const SizedBox(width: 360, child: Divider(color: Color(0xFFF2E5FF))),
                  const SizedBox(height: 20),
                  buildRow(context, "images/setting.png", "الإعدادات", Icons.arrow_back_ios_new_rounded),
                  const SizedBox(height: 20),
                  const SizedBox(width: 360, child: Divider(color: Color(0xFFF2E5FF))),
                  const SizedBox(height: 20),
                  buildRow(context, "images/logout.png", "خروج", Icons.arrow_back_ios_new_rounded),
                  const SizedBox(height: 20),
                  const SizedBox(width: 360, child: Divider(color: Color(0xFFF2E5FF))),
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
              child: GestureDetector(
                onTap: _openGallery,
                onDoubleTap: _clearSelectedImage, // Appel de la fonction pour supprimer l'image sélectionnée
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    _selectedImage != null
                        ? ClipOval(
                            child: Image.file(
                              _selectedImage!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            "images/person.png",
                            width: 100,
                            height: 100,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget buildRow(BuildContext context, String imagePath, String text, IconData icon) {
    return GestureDetector(
      onTap: () async {
        if (imagePath == "images/answer.png") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const history()),
          );
        } else if (imagePath == "images/setting.png") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UpdateData()),
          );
        } else if (imagePath == "images/logout.png") {
          disconnectFromDevice();
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login_screen(),
            ),
          );
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
              style: GoogleFonts.amiri(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 25,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            Image.asset(imagePath, width: 25, height: 25),
          ],
        ),
      ),
    );
  }
}
