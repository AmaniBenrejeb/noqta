import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mypfe/btm_nav_bar.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:mypfe/subjects/math/mathquestions.dart';
import 'package:mypfe/subjects/science/sciencequestions.dart';
import 'package:mypfe/subjects/geo/geoquestions.dart';
import 'package:mypfe/subjects/history/historyquestions.dart';
import 'package:mypfe/subjects/din/dinquestions.dart';
import 'package:google_fonts/google_fonts.dart'; // Importez la bibliothèque google_fonts


import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue/flutter_blue.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? targetDevice;
  BluetoothCharacteristic? targetCharacteristic;
  List<int> receivedData = [1];
  var bluetoothName = "ESP32_BLE";

  Future<void> scanAndConnect() async {
    try {
      if (await Permission.bluetoothScan.request().isGranted &&
          await Permission.bluetoothConnect.request().isGranted &&
          await Permission.location.request().isGranted) {
        // Permissions granted, proceed with scanning and connecting
        await startScan();
      } else {
        print('Permissions not granted');
      }
    } catch (e) {
      print('Error during scanning: $e');
    }
  }

  Future<void> startScan() async {
    StreamSubscription<ScanResult>? scanSubscription;
    Timer? timeoutTimer;

    const int scanTimeout = 60;

    scanSubscription = flutterBlue.scan().listen((scanResult) {
      if (scanResult.device.name == '$bluetoothName') {
        targetDevice = scanResult.device;
        scanSubscription?.cancel();
        timeoutTimer?.cancel();
        print('Target device found and scanning stopped.');
         
        connectToDevice();
        AnimatedSnackBar.material(
        'تم العثور على الجهاز المستهدف ,جهازك متصل بالبلوتوث',
        type: AnimatedSnackBarType.success,
        duration: Duration(seconds: 6),
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
      }
    });

    timeoutTimer = Timer(Duration(seconds: scanTimeout), () {
      scanSubscription?.cancel();
      flutterBlue.stopScan();
      print('Scanning timed out. Target device not found.');
       AnimatedSnackBar.material(
   'لم يتم العثور على الجهاز المستهدف',
        type: AnimatedSnackBarType.error,
        duration: Duration(seconds: 6),
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
    });
  }

  Future<void> connectToDevice() async {
    if (targetDevice != null) {
      try {
        await targetDevice!.connect();
        discoverServices();
      } catch (e) {
        print('Error connecting to device: $e');
      }
    }
  }
void discoverServices() async {
    List<BluetoothService> services = await targetDevice!.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        if (characteristic.uuid.toString() == "e844e406-79f7-443e-8d29-9cfe8933304d"
               
            ) {
          targetCharacteristic = characteristic;
          subscribeToCharacteristic();
        }
      });
    });
  }

  void subscribeToCharacteristic() async {
    if (targetCharacteristic != null) {
      await targetCharacteristic!.setNotifyValue(true);
      targetCharacteristic!.value.listen((value) {
        setState(() {
          receivedData = value;
          print('value is: $value');
        });
      });
    }
  }
 @override
  void initState() {
    super.initState();
    scanAndConnect();
 
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.4; 
    return  Scaffold(
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center, // Centrer les cartes horizontalement
          runSpacing: 16.0, // Espacement vertical entre les lignes de cartes
          children: [
            _buildCategoryRow(
              context,
              'images/experiments.png',
              'علوم',
             const Color(0xFF79C5F7), // Couleur spécifique pour la science
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScQu(),
                  ),
                );
              },
              cardWidth,
            ),
            _buildCategoryRow(
              context,
              'images/calculator.png',
              'رياضيات',
             const  Color(0xFFD27AFA), // Couleur spécifique pour les mathématiques
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MathQu(),
                  ),
                );
              },
              cardWidth,
            ),
            _buildCategoryRow(
              context,
              'images/quran.png',
              'دين',
             const  Color(0xFF187F5B), // Couleur spécifique pour la religion
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DinQu(),
                  ),
                );
              },
              cardWidth,
            ),
            _buildCategoryRow(
              context,
              'images/geography.png',
              'جغرافيا',
             const Color(0xFF7D79F7), // Couleur spécifique pour la géographie
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GeoQu(),
                  ),
                );
              },
              cardWidth,
            ),
            _buildCategoryRow(
              context,
              'images/history.png',
              'تاريخ',
             const Color(0xFFFED159), // Couleur spécifique pour l'histoire
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HiQu(),
                  ),
                );
              },
              cardWidth,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildCategoryRow(
    BuildContext context,
    String imagePath,
    String label,
    Color color, // Ajoutez un paramètre de couleur
    VoidCallback onPressed,
    double cardWidth,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Ajouter un padding horizontal pour espacer les paires de cartes
      child: SizedBox(
        width: cardWidth,
        child: Stack(
          children: [
            // Carte colorée
            Positioned(
              top:0 ,
              bottom: cardWidth *0.5,
              left: 0,
              right: 0,
              child: Container(
                height: cardWidth * 0.5 , // Hauteur de la carte colorée
                decoration: BoxDecoration(
                  color: color, // Couleur spécifique pour chaque sujet
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            // Carte principale
            _buildCategoryButton(
              context,
              imagePath,
              label,
              onPressed,
              cardWidth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    String imagePath,
    String label,
    VoidCallback onPressed,
    double cardWidth,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: cardWidth,
          height: cardWidth * 1.2, // Garder le ratio hauteur-largeur pour ne pas déformer les images
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: cardWidth * 0.6, // 60% de la largeur de la carte
                height: cardWidth * 0.6, // 60% de la largeur de la carte pour garder le ratio
                fit: BoxFit.contain, // Ajuster l'image pour tenir dans la boîte en conservant ses proportions
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.lateef( // Utilisez GoogleFonts.lateef pour appliquer la police Lateef
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}