// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/screens/cards/anime_card.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:jikan_api/jikan_api.dart';

class GetList extends StatelessWidget {
  late AsyncSnapshot<dynamic> snapshot;
  String list;
  GetList({
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
                              child: Text('No',
                                  style: Theme.of(context).textTheme.caption),
                            ),
                            TextButton(
                              onPressed: () {
                                DataBaseService().deleteAnimeFromList(
                                    list, animeList.data![index].malId);
                                Navigator.pop(context);
                              },
                              child: Text('Yes',
                                  style: Theme.of(context).textTheme.caption),
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
            return Text('no data');
          }
        });
  }
}
