import 'package:flutter/material.dart';

class loginBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.84,
            right: MediaQuery.of(context).size.width * 0.77,
            child: ClipOval(
              child: Container(
                width: 150,
                height: 150,
                color: Color(0xFFF2E5FF),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.42,
            left: MediaQuery.of(context).size.width * 0.7,
            child: ClipOval(
              child: Container(
                width: 150,
                height: 150,
                color: Color(0xFFF2E5FF),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.79,
            right: MediaQuery.of(context).size.width * 0.77,
            child: ClipOval(
              child: Container(
                width: 150,
                height: 150,
                color: Color(0xFFF2E5FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}