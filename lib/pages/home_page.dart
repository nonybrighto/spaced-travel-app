import 'package:flutter/material.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/pages/home_views/discovery.dart';
import 'package:spaced_trip_scheduler/pages/home_views/navigate.dart';
import 'package:spaced_trip_scheduler/pages/home_views/profile.dart';

import 'home_views/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _getCurrentPage(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kBackgroundColor.withOpacity(0.7),
              kBackgroundColor,
            ],
            stops: const [0.0, 0.5],
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconSize: 35,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: kPrimaryColor,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.navigation),
              label: 'Navigate',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Search',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const Discovery();
      case 1:
        return const Navigate();
      case 2:
        return const Profile();
      case 3:
        return const Search();
      default:
        return const Discovery();
    }
  }
}
