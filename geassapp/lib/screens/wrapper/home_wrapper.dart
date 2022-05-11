// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geassapp/main.dart';
import 'package:geassapp/screens/home/home_page.dart';
import 'package:geassapp/screens/homeNavPages/anime_lists.dart';
import 'package:geassapp/screens/homeNavPages/home.dart';
import 'package:geassapp/screens/homeNavPages/profile.dart';
import 'package:geassapp/screens/wrapper/landing_page.dart';
import 'package:geassapp/screens/wrapper/user_name_page.dart';
import 'package:geassapp/services/database_service.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center();
          } else if (snapshot.hasData) {
            //if google email is in the firebase database then send to homepage else go to UserNamePage
            return FutureBuilder(
              future: DataBaseService().searchUser(snapshot.data!.uid),
              builder: (BuildContext context, AsyncSnapshot<String> snap) {
                switch (snap.connectionState) {
                  case ConnectionState.waiting:
                    return Text('Loading....');
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snap.error}');
                    } else {
                      print("from fireabse");
                      print(snap.data);
                      if (snap.data != snapshot.data!.uid) {
                        return UserNamePage(snapshot.data!.email);
                      } else {
                        return HomePage();
                      }
                    }
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return LandingPage();
          }
        },
      ),
    );
  }
}
