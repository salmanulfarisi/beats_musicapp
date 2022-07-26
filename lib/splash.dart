import 'dart:async';

import 'package:beats/navigatioscreen.dart';
import 'package:beats/utilits/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rate_my_app/src/core.dart';

class ScreenSplash extends StatefulWidget {
  final RateMyApp rateMyApp;
  const ScreenSplash({
    Key? key,
    required this.rateMyApp,
  }) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    // requestPermission();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ScreenNavigatioin(
                      rateMyApp: widget.rateMyApp,
                    ))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.9),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                const Positioned(
                  left: 80,
                  top: 80,
                  child: SizedBox(
                    child: Text(
                      'Beats',
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: white,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 120,
                  top: 180,
                  child: SizedBox(
                    child: Text(
                      'The Magic of Voices',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Lottie.asset('assets/music_notes.json'),
                ),
              ]),
              SizedBox(
                child: Lottie.asset('assets/music_visialicer.json'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void requestPermission() async {
  //   await Permission.storage.request();
  // }
}
