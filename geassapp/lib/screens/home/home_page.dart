// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geassapp/providers/google_signin.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logout();
          },
          child: Text('LOGOUT'),
        ),
      ),
    );
  }
}
