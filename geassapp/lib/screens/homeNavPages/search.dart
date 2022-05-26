// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/screens/cards/anime_card.dart';
import 'package:geassapp/services/database_service.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Container(
                  height: 150.h,
                  width: 1000.w,
                  child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[700],
                            size: 25,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.5,
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                          ),
                          hintText: "Search",
                          fillColor: Colors.black54))),
            ),
          ),
          lookingFor(),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 15),
            child: Text(
              'Top Airing Anime',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Container(
              height: 450.h,
              child: FutureBuilder(
                  future: DataBaseService().fetchTop(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      //do as intended
                      print(snapshot.data);
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
                                    image: NetworkImage(
                                        snapshot.data![index].imageUrl),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Text('null');
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Padding lookingFor() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Center(
        child: Container(
          height: 500.h,
          width: 600.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text('What are you',
                    style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w100)),
              ),
              Container(
                child: Text('looking for ?',
                    style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w100)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                    child: Text(
                  'Over 10,000 animes to add ',
                  style: TextStyle(color: Colors.grey[600]),
                )),
              ),
              Container(
                child: Text(
                  'to your watch list',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
