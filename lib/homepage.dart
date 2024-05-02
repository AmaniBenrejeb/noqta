import 'package:flutter/material.dart';
import 'package:mypfe/btm_nav_bar.dart';
import 'package:mypfe/subjects/math/mathquestions.dart';
import 'package:mypfe/subjects/science/sciencequestions.dart';
import 'package:mypfe/subjects/geo/geoquestions.dart';
import 'package:mypfe/subjects/history/historyquestions.dart';
import 'package:mypfe/subjects/din/dinquestions.dart';
import 'package:google_fonts/google_fonts.dart'; // Importez la bibliothèque google_fonts

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
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
              const Color(
                  0xFFD27AFA), // Couleur spécifique pour les mathématiques
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
              const Color(0xFF187F5B), // Couleur spécifique pour la religion
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
      padding: const EdgeInsets.symmetric(
          horizontal:
              8.0), // Ajouter un padding horizontal pour espacer les paires de cartes
      child: SizedBox(
        width: cardWidth,
        child: Stack(
          children: [
            // Carte colorée
            Positioned(
              top: 0,
              bottom: cardWidth * 0.5,
              left: 0,
              right: 0,
              child: Container(
                height: cardWidth * 0.5, // Hauteur de la carte colorée
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
          height: cardWidth *
              1.2, // Garder le ratio hauteur-largeur pour ne pas déformer les images
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: cardWidth * 0.6, // 60% de la largeur de la carte
                height: cardWidth *
                    0.6, // 60% de la largeur de la carte pour garder le ratio
                fit: BoxFit
                    .contain, // Ajuster l'image pour tenir dans la boîte en conservant ses proportions
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.lateef(
                  // Utilisez GoogleFonts.lateef pour appliquer la police Lateef
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
