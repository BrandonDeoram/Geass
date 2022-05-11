// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geassapp/providers/google_signin.dart';
import 'package:geassapp/screens/homeNavPages/anime_lists.dart';
import 'package:geassapp/screens/homeNavPages/home.dart';
import 'package:geassapp/screens/homeNavPages/profile.dart';
import 'package:geassapp/screens/homeNavPages/search.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget? _child;
  @override
  void initState() {
    _child = Profile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _child,
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
            icon: Icons.home,
          ),
          FluidNavBarIcon(
            icon: Icons.search,
          ),
          FluidNavBarIcon(
            icon: Icons.list,
          ),
          FluidNavBarIcon(
            icon: Icons.person_sharp,
          ),
        ],
        onChange: _handleNavigationChange,
        style: FluidNavBarStyle(
            barBackgroundColor: Colors.black,
            iconSelectedForegroundColor: Colors.white,
            iconUnselectedForegroundColor: Colors.grey),
        scaleFactor: 1.0,
        defaultIndex: 0,
        animationFactor: 0.6,
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = Home();
          break;
        case 1:
          _child = Search();
          break;
        case 2:
          _child = AnimeLists();
          break;
        case 3:
          _child = Profile();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 100),
        child: _child,
      );
    });
  }
}
