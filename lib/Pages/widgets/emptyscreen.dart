import 'package:flutter/material.dart';

Widget emptyScreen(
  BuildContext context,
  int turns,
  String text1,
  double size1,
  String text2,
  double size2,
  String text3,
  double size3, {
  bool useWhite = false,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: turns,
            child: Text(
              text1,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: size1,
                color: Colors.grey,
                // color: useWhite ? Colors.white : Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                text2,
                style: TextStyle(
                  fontSize: size2,
                  color: Colors.amberAccent,
                  // color: useWhite ? Colors.white : Colors.amberAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                text3,
                style: TextStyle(
                    fontSize: size3,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                    // color: useWhite ? Colors.white : null,
                    ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
