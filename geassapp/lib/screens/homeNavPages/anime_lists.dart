// ignore_for_file: prefer_const_constructors,, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/screens/cards/anime_card.dart';
import 'package:geassapp/screens/homeNavPages/see_all_page.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:geassapp/widgets/GetList.dart';
import 'package:geassapp/widgets/see_all_list.dart';
import 'package:jikan_api/jikan_api.dart';

class AnimeLists extends StatefulWidget {
  const AnimeLists({Key? key}) : super(key: key);

  @override
  State<AnimeLists> createState() => _AnimeListsState();
}

class _AnimeListsState extends State<AnimeLists> {
  List<Anime> planToWatch = [];
  late final Stream fireBaseData;
  @override
  void initState() {
    fireBaseData = DataBaseService().getAnimeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(4.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                'Watch Lists',
                style: Theme.of(context).textTheme.headline4,
              )),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 5),
                    child: Text(
                      'Plan to watch',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(191, 0, 0, 0),
                    child: TextButton(
                        onPressed: () {
                          var list = {'planToWatch': 1}.entries.toList();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeeAll(list[0], true)));
                        },
                        child: Text(
                          'See all >',
                          style: Theme.of(context).textTheme.caption,
                        )),
                  ),
                ],
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
                            height: 390.h,
                            child: GetList(
                                snapshot: snapshot, list: "planToWatch"),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  'Watching',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(230, 0, 0, 0),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SeeAllList(
                                                  list: "Watching",
                                                  snap: snapshot)));
                                    },
                                    child: Text(
                                      'See all >',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            height: 390.h,
                            child:
                                GetList(snapshot: snapshot, list: "watching"),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0, bottom: 0),
                                child: Text(
                                  'Finished',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(250, 0, 0, 0),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SeeAllList(
                                                  list: "Finished",
                                                  snap: snapshot)));
                                    },
                                    child: Text(
                                      'See all >',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            height: 390.h,
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
