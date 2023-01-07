// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geassapp/models/MALAnime.dart';
import 'package:geassapp/models/anime_class.dart';
import 'package:geassapp/screens/cards/anime_card.dart';
import 'package:geassapp/screens/homeNavPages/see_all_page.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:http/http.dart' as http;

//Home
// Future<List<MALAnime>> fetchAlbum() async {
//   final response = await http
//       .get(Uri.parse('https://api.jikan.moe/v4/top/anime?limit=4&limit=20'));

//   if (response.statusCode == 200) {
//     dynamic data = jsonDecode(response.body);
//     List<MALAnime> malAnime = [];
//     for (var i = 0; i < data['data'].length; i++) {
//       malAnime.add(MALAnime.fromJson(data['data'][i]));
//     }

//     return malAnime;
//   } else {
//     throw Exception('Failed to load album');
//   }
// }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<MALAnime>> reccomendedAnime;
  late Future<List<MALAnime>> rec;
  Map<String, int> cat = {
    "Recommended": 1,
    "Action": 205,
    // "Adventure": 21,
  };

  @override
  void initState() {
    super.initState();
    // reccomendedAnime = DataBaseService().getReccomendedAnime(1);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Stack(
                  children: [
                    Container(
                      height: 800.h,
                      width: 1100.w,
                      decoration: BoxDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(60.0.r),
                            bottomRight: Radius.circular(60.0.r),
                            topLeft: Radius.circular(60.0.r),
                            bottomLeft: Radius.circular(60.0.r)),
                        child: Image(
                          image: NetworkImage(
                              'https://data.whicdn.com/images/333396361/original.gif'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100.h,
                        child: const Image(
                          image: AssetImage("assets/geassSym.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 700.h),
                      child: Center(
                        child: Container(
                          height: 200.h,
                          width: 400.w,
                          child: Image(
                            image: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Kimetsu_no_Yaiba_logo.svg/2560px-Kimetsu_no_Yaiba_logo.svg.png'),
                            fit: BoxFit.fitWidth,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              getCatWidgets(cat, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget getCatWidgets(Map<String, int> cat, BuildContext context) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < cat.length; i++) {
      list.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 470.h,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      cat.keys.elementAt(i),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(160, 20, 0, 0),
                    child: TextButton(
                      onPressed: () {
                        var list = cat.entries.toList();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAll(list[i], false)));
                      },
                      child: Text(
                        "See all >",
                        style: TextStyle(fontSize: 12),
                      ),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                height: 400.h,
                child: futureBuilderMethod(cat.values.elementAt(i)),
              ),
            ),
          ],
        ),
      );
    }
    return Column(children: list);
  }

  futureBuilderMethod(int genreID) {
    return FutureBuilder(
        future: DataBaseService().getReccomendedAnime(genreID),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitSpinningLines(color: Colors.grey),
            );
          } else if (snapshot.hasData) {
            //do as intended
            print("printing snapshot: {$snapshot}");
            return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      indent: 10,
                    ),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnimeCard(
                                  anime: snapshot.data![index],
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
                          image: NetworkImage(snapshot.data![index].imageUrl),
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
