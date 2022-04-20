// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geassapp/providers/google_signin.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Profile Page'),
          TextButton(
              onPressed: () {
                Provider.of<GoogleSignInProvider>(context, listen: false)
                    .logout();
              },
              child: Text('Logout')),
        ],
      ),
    );
  }
}
