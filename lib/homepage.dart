import 'package:flutter/material.dart';
import 'package:mypfe/btm_nav_bar.dart';
//import 'package:google_nav_bar/google_nav_bar.dart';
//import 'package:mypfe/btmnavbar.dart';
import 'package:mypfe/math/mathquestions.dart';
import 'package:mypfe/science/sciencequestions.dart';
import 'package:mypfe/geo/geoquestions.dart';
import 'package:mypfe/history/historyquestions.dart';
import 'package:mypfe/din/dinquestions.dart';
//import 'package:mypfe/myaccount.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // Utilisation de Column comme parent
        children: [
          Expanded(
            // Utilisation de Expanded à l'intérieur de Column
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: -98,
                    top: 219,
                    child: SizedBox(
                      width: 506,
                      height: 348,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 356,
                            top: 0,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: const ShapeDecoration(
                                color: Color(0xADF2E5FF),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 198,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: const ShapeDecoration(
                                color: Color(0xADF2E5FF),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //fin BG
                  Positioned(
                    left: 40,
                    top: 78,
                    child: SizedBox(
                      width: 600,
                      height: 598,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: SizedBox(
                              width: 306,
                              height: 179,
                              child: GestureDetector(
                                //Tap
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ScQu()),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: SizedBox(
                                        width: 145,
                                        height: 179,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 34,
                                              child: Container(
                                                width: 145,
                                                height: 145,
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFF79C5F7),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  shadows: const [
                                                    BoxShadow(
                                                      color: Color(0x30000000),
                                                      blurRadius: 8.10,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Positioned(
                                              left: 53,
                                              top: 152,
                                              child: Text(
                                                'علوم',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: 'Radio Canada',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                width: 145,
                                                height: 145,
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFF5F5F5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  shadows: const [
                                                    BoxShadow(
                                                      color: Color(0x30000000),
                                                      blurRadius: 8.10,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 26,
                                              top: 26,
                                              child: Container(
                                                width: 92.06,
                                                height: 92.06,
                                                decoration: ShapeDecoration(
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                        'images/experiments.png'),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //fin science
                                    Positioned(
                                      left: 161,
                                      top: 0,
                                      child: SizedBox(
                                        width: 145,
                                        height: 179,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MathQu()),
                                            );
                                          },
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 34,
                                                child: Container(
                                                  width: 145,
                                                  height: 145,
                                                  decoration: ShapeDecoration(
                                                    color: const Color(0xFFD27AFA),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x30000000),
                                                        blurRadius: 8.10,
                                                        offset: Offset(0, 1),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 145,
                                                  height: 145,
                                                  decoration: ShapeDecoration(
                                                    color: const Color(0xFFF5F5F5),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x30000000),
                                                        blurRadius: 8.10,
                                                        offset: Offset(0, 1),
                                                        spreadRadius: 0,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 33,
                                                top: 34,
                                                child: Container(
                                                  width: 78,
                                                  height: 78,
                                                  decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/calculator.png'),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                left: 45,
                                                top: 152,
                                                child: Text(
                                                  'رياضيات',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontFamily: 'Radio Canada',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //fin math
                          Positioned(
                            left: 161,
                            top: 426,
                            child: SizedBox(
                              width: 145,
                              height: 172,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const DinQu()),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 27,
                                      child: Container(
                                        width: 145,
                                        height: 145,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF187F5B),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0x30000000),
                                              blurRadius: 8.10,
                                              offset: Offset(0, 1),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 145,
                                        height: 137,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFF5F5F5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0x30000000),
                                              blurRadius: 8.10,
                                              offset: Offset(0, 1),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 22,
                                      top: 19,
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: ShapeDecoration(
                                          image: const DecorationImage(
                                            image:
                                                AssetImage('images/quran.png'),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 64,
                                      top: 143,
                                      child: Text(
                                        'دين',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'Radio Canada',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //fin din
                          Positioned(
                            left: 0,
                            top: 215,
                            child: SizedBox(
                              width: 600,
                              height: 598,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 161,
                                    top: 0,
                                    child: SizedBox(
                                      width: 600,
                                      height: 598,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const GeoQu ()),
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 33,
                                              child: Container(
                                                width: 145,
                                                height: 145,
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFF7D79F7),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  shadows: const [
                                                    BoxShadow(
                                                      color: Color(0x30000000),
                                                      blurRadius: 8.10,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                width: 145,
                                                height: 145,
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFF5F5F5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  shadows: const [
                                                    BoxShadow(
                                                      color: Color(0x30000000),
                                                      blurRadius: 8.10,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 27,
                                              top: 22,
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: ShapeDecoration(
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                        'images/geography.png'),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Positioned(
                                              left: 52,
                                              top: 153,
                                              child: Text(
                                                'جغرافيا',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: 'Radio Canada',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //fin geo
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: SizedBox(
                                      width: 600,
                                      height: 598,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const HiQu()),
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 33,
                                              child: Container(
                                                width: 145,
                                                height: 145,
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFFED159),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  shadows: const [
                                                    BoxShadow(
                                                      color: Color(0x30000000),
                                                      blurRadius: 8.10,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                width: 145,
                                                height: 145,
                                                decoration: ShapeDecoration(
                                                  color: const Color(0xFFF5F5F5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  shadows: const [
                                                    BoxShadow(
                                                      color: Color(0x30000000),
                                                      blurRadius: 8.10,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 22,
                                              top: 22,
                                              child: Container(
                                                width: 100,
                                                height: 100,
                                                decoration: ShapeDecoration(
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                        'images/history.png'),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Positioned(
                                              left: 56,
                                              top: 153,
                                              child: Text(
                                                'تاريخ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: 'Radio Canada',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //fin history
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //navigation bar
      bottomNavigationBar: BottomNavBar(),

      
    );
  }
}
