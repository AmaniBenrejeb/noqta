import 'package:flutter/material.dart';

class resetPasswordBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.8,
            right: MediaQuery.of(context).size.width * 0.75,
            child: ClipOval(
              child: Container(
                width: 250,
                height: 250,
                color: Color(0xFFF2E5FF),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.51,
            left: MediaQuery.of(context).size.width * 0.7,
            child: ClipOval(
              child: Container(
                width: 250,
                height: 250,
                color: Color(0xFFF2E5FF),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            right: MediaQuery.of(context).size.width * 0.74,
            child: ClipOval(
              child: Container(
                width: 250,
                height: 250,
                color: Color(0xFFF2E5FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}