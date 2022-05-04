// ignore_for_file: prefer_const_constructors,, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/screens/cards/anime_card.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:jikan_api/jikan_api.dart';

class AnimeLists extends StatefulWidget {
  const AnimeLists({Key? key}) : super(key: key);

  @override
  State<AnimeLists> createState() => _AnimeListsState();
}

class _AnimeListsState extends State<AnimeLists> {
  List<Anime> planToWatch = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Anime Lists'),
            Text('Plan to watch'),
            IconButton(
              onPressed: () {
                DataBaseService().getAnimeList();
              },
              icon: Icon(
                Icons.ac_unit,
                color: Colors.white,
              ),
            ),
            StreamBuilder(
                stream: DataBaseService().getAnimeList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    //do as intended

                    DataBaseService()
                        .fetchAnime(snapshot.data['planToWatch'])
                        .then((value) {
                      if (mounted) {
                        setState(() {
                          planToWatch = value;
                        });
                      }
                    });

                    return Container(
                      height: 400.h,
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                indent: 10,
                              ),
                          scrollDirection: Axis.horizontal,
                          itemCount: planToWatch.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AnimeCard(
                                            anime: planToWatch[index],
                                          )),
                                );
                              },
                              child: Container(
                                width: 280.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0.r),
                                      bottomRight: Radius.circular(10.0.r),
                                      topLeft: Radius.circular(10.0.r),
                                      bottomLeft: Radius.circular(10.0.r)),
                                  child: Image(
                                    image: NetworkImage(
                                        planToWatch[index].imageUrl),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Text('null');
                  }
                })
          ],
        ),
      ),
    );
  }
}
