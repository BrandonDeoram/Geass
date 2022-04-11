// @dart=2.9
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/providers/anime_notifier.dart';
import 'package:geassapp/providers/google_signin.dart';
import 'package:geassapp/screens/home/home_page.dart';
import 'package:geassapp/screens/wrapper/home_wrapper.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 97,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Colors.white),
  headline2: GoogleFonts.poppins(
      fontSize: 61,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Colors.white),
  headline3: GoogleFonts.poppins(
      fontSize: 48, fontWeight: FontWeight.w400, color: Colors.white),
  headline4: GoogleFonts.poppins(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  headline5: GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
  headline6: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Colors.white),
  subtitle1: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Colors.white),
  subtitle2: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Colors.white),
  bodyText1: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.white),
  bodyText2: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  button: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Colors.white),
  caption: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: Colors.white),
  overline: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Colors.white),
);

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AnimeNotifier()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ],
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.grey,
            primaryColor: Colors.white,
            textTheme: textTheme,
          ),
          home: Wrapper(),
        ),
        designSize: const Size(1080, 1920),
      ),
    );
  }
}
