import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/models/anime.dart';

// ignore_for_file: prefer_const_constructors
class AnimeCard extends StatelessWidget {
  final Anime anime;
  // ignore: use_key_in_widget_constructors
  const AnimeCard({required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0.0.r),
                bottomRight: Radius.circular(120.0.r),
                topLeft: Radius.circular(0.0.r),
                bottomLeft: Radius.circular(0.0.r)),
            child: Container(
              color: Colors.green,
              height: 900.h,
              width: 1200.w,
              child: Image(
                image: NetworkImage(anime.image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ],
      )),
    );
  }
}
