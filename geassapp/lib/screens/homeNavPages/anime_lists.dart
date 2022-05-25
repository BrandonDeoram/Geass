// ignore_for_file: prefer_const_constructors,, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/screens/cards/anime_card.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:geassapp/widgets/GetList.dart';
import 'package:jikan_api/jikan_api.dart';

class AnimeLists extends StatefulWidget {
  const AnimeLists({Key? key}) : super(key: key);

  @override
  State<AnimeLists> createState() => _AnimeListsState();
}

class _AnimeListsState extends State<AnimeLists> {
  List<Anime> planToWatch = [];
  final Stream fireBaseData = DataBaseService().getAnimeList();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                'Watch Lists',
                style: Theme.of(context).textTheme.headline4,
              )),
              Padding(
                padding: EdgeInsets.only(bottom: 10, top: 5),
                child: Text(
                  'Plan to watch',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              StreamBuilder(
                  stream: fireBaseData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 400.h,
                            child: GetList(
                                snapshot: snapshot, list: "planToWatch"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              'Watching',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            height: 400.h,
                            child:
                                GetList(snapshot: snapshot, list: "watching"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              'Finished',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            height: 400.h,
                            child:
                                GetList(snapshot: snapshot, list: "finished"),
                          ),
                        ],
                      );
                    } else {
                      return Text('null');
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
