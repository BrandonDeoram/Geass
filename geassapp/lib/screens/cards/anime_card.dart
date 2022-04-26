import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/models/anime_class.dart';
import 'package:geassapp/providers/google_signin.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// ignore_for_file: prefer_const_constructors
class AnimeCard extends StatefulWidget {
  final AnimeItem anime;
  // ignore: use_key_in_widget_constructors
  const AnimeCard({required this.anime});

  @override
  State<AnimeCard> createState() => _AnimeCardState();
}

class _AnimeCardState extends State<AnimeCard> {
  @override
  Widget build(BuildContext context) {
    double animeScore = (widget.anime.score! / 2).ceilToDouble();
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50)),
                  child: Container(
                    height: 800.h,
                    width: 1200.w,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaY: 2.8, sigmaX: 2.8),
                      child: Image(
                        image: NetworkImage(widget.anime.imageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                child: Container(
                  height: 800.h,
                  width: 800.w,
                  child: Image(
                    image: NetworkImage(widget.anime.imageUrl),
                    fit: BoxFit.contain,
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
              Padding(
                padding: EdgeInsets.fromLTRB(338, 255, 0, 0),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(335, 253, 0, 0),
                child: IconButton(
                    iconSize: 40.0,
                    onPressed: () {
                      // DataBaseService()
                      //     .addAnimeToList('favourites', widget.anime.animeId);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 40.0,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 300, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.anime.title,
                      style: TextStyle(fontSize: 25),
                    ),
                    Row(
                      children: [
                        for (var i in widget.anime.genres)
                          Text(
                            i.name + " ",
                            style: TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Colors.grey),
                          )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Container(
                            height: 20,
                            child: RatingBarIndicator(
                              rating: animeScore,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: 10),
                          child: Text(animeScore.toString()),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        right: 10,
                      ),
                      child: Container(
                        height: 450.h,
                        child: SingleChildScrollView(
                          child: ReadMoreText(
                            widget.anime.synopsis.toString(),
                            trimLines: 10,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '"',
                            trimExpandedText: ' show less',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: SpeedDial(
        spaceBetweenChildren: 40,
        overlayColor: Colors.transparent,
        buttonSize: Size(50, 50),
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.white,
        direction: SpeedDialDirection.right,
        children: [
          SpeedDialChild(
              child: Icon(Icons.playlist_add_rounded),
              onTap: () {
                //Pass through the animeID to Database
                DataBaseService()
                    .addAnimeToList('planToWatch', widget.anime.malId);
              }),
          SpeedDialChild(
              child: Icon(Icons.remove_red_eye),
              onTap: () {
                DataBaseService()
                    .addAnimeToList('watching', widget.anime.malId);
              }),
          SpeedDialChild(
              child: Icon(Icons.done),
              onTap: () {
                DataBaseService()
                    .addAnimeToList('finished', widget.anime.malId);
              }),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white12,
        shape: const CircularNotchedRectangle(),
        notchMargin: 14.0,
        child: Container(
          height: 80.h,
        ),
      ),
    );
  }
}