// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/providers/google_signin.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage();

  @override
  State<LandingPage> createState() => _LangingPageState();
}

class _LangingPageState extends State<LandingPage> {
  @override

  //Plant to watch
  //-> 10075
//Animes
//->10075

//collcetion.path(planttowatch).getDocs() -> Getting animeID's then using streambuidler->pathtoanime.match(animeID's) and display that
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SafeArea(
                child: SizedBox(
                  height: 600.h,
                  child: const Image(
                    image: AssetImage("assets/geassSym.png"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: FlatButton.icon(
                  onPressed: () {
                    provider.googleLogin();
                  },
                  icon: SizedBox(
                    height: 50.h,
                    child: Image(
                      image: NetworkImage(
                          'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Continue with Google",
                        style: Theme.of(context).textTheme.button),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 5.h,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
