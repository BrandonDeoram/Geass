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
  final Stream fireBaseData = DataBaseService().getAnimeList();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                'Anime Lists',
                style: Theme.of(context).textTheme.headline4,
              )),
              Padding(
                padding: EdgeInsets.only(bottom: 10, top: 20),
                child: Text(
                  'Plan to watch',
                  style: Theme.of(context).textTheme.headline5,
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
                            child: getList(
                                snapshot: snapshot, list: "planToWatch"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: Text(
                              'Watching',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          Container(
                            height: 400.h,
                            child:
                                getList(snapshot: snapshot, list: "watching"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            child: Text(
                              'Finished',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          Container(
                            height: 400.h,
                            child:
                                getList(snapshot: snapshot, list: "finished"),
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

class getList extends StatelessWidget {
  late AsyncSnapshot<dynamic> snapshot;
  String list;
  getList({
    required this.snapshot,
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DataBaseService().fetchAnime(snapshot.data[list]),
        builder: (BuildContext context, AsyncSnapshot<List<Anime>> animeList) {
          if (animeList.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (animeList.hasData) {
            //do as intended
            print(animeList.data);
            return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      indent: 10,
                    ),
                scrollDirection: Axis.horizontal,
                itemCount: animeList.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnimeCard(
                                  anime: animeList.data![index],
                                )),
                      );
                    },
                    onLongPress: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Theme.of(context).backgroundColor,
                          title: Text(
                            'Delete ' + animeList.data![index].title + ' ?',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                DataBaseService().deleteAnimeFromList(
                                    list, animeList.data![index].malId);
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
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
                          image: NetworkImage(animeList.data![index].imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Text('null');
          }
        });
  }
}
