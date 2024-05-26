// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rankgroupassignment/app/palette.dart';
import 'package:rankgroupassignment/screen/blocking_section_screen.dart';
import 'package:rankgroupassignment/screen/card_section_screen.dart';

class NavigationScreen extends StatefulWidget {
  // Updated name
  const NavigationScreen({super.key});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    CardSectionScreen(title: 'Card Validation'),
    BlockingSectionScreen(title: 'Blocking'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Card Validation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.block),
            label: 'Country Blocking',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colourRankBluePrimary,
        unselectedItemColor: colourRankGreyDark,
        backgroundColor: colourWhite,
        onTap: _onItemTapped,
      ),
    );
  }
}
