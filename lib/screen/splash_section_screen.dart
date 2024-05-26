// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rankgroupassignment/screen/navigation_page.dart';
import 'package:rankgroupassignment/app/palette.dart';

class SplashSectionScreen extends StatefulWidget {
  const SplashSectionScreen({super.key});

  @override
  _SplashSectionScreenState createState() => _SplashSectionScreenState();
}

class _SplashSectionScreenState extends State<SplashSectionScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/Rank_Group_Logo_RGB_Gold.png',
          color: colourRankBluePrimary,
        ),
      ),
    );
  }
}
