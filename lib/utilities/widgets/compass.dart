import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class Compass extends StatelessWidget {
  final double degree;
  final int time;

  const Compass({Key? key, required this.degree, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Transform.rotate(
            angle: radians(degree), // Convert degrees to radians
            child: const Icon(
              CupertinoIcons.compass, // You can use any compass icon or image
              size: 120.0,
              color: Colors.white
            ),
          ),
          const Positioned(
              top: 18,
              bottom: 0,
              left: 55,
              right: 0,
              child: Text(
                'N',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              )),
          const Positioned(
              top: 86,
              bottom: 0,
              left: 57,
              right: 0,
              child: Text(
                'S',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              )),
          const Positioned(
              top: 50,
              bottom: 0,
              left: 20,
              right: 50,
              child: Text(
                'W',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              )),
          const Positioned(
              top: 52,
              bottom: 0,
              left: 90,
              right: 20,
              child: Text(
                'E',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              )),
        ],
      ),
    );
  }
}
