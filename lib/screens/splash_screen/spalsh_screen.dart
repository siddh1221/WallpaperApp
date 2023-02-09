// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpapper_app/screens/home_page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  askPermission() async {
    var status = await Permission.storage.request();
    status;
  }

  @override
  void initState() {
    super.initState();
    askPermission();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Image(
            image: AssetImage(
              "assets/Wallpaper.png",
            ),
          ),
        )
        // child: FlutterLogo(size: MediaQuery.of(context).size.height),
        );
  }
}
