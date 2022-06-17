// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/screens/cards/anime_card.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:jikan_api/jikan_api.dart';

class SeeAllList extends StatefulWidget {
  final String list;
  final AsyncSnapshot snap;

  SeeAllList({Key? key, required this.list, required this.snap})
      : super(key: key);
  @override
  State<SeeAllList> createState() => _SeeAllListState();
}

class _SeeAllListState extends State<SeeAllList> {
  late Future<dynamic> data;
  @override
  void initState() {
    // TODO: implement initState
    var newList = widget.snap.data['watching'];
    data = DataBaseService().fetchAnime(newList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(32, 32, 32, 100),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.list,
            style: Theme.of(context).textTheme.headline5,
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(32, 32, 32, 20),
        ),
        body: buildGridViewList(widget.snap));
  }

  FutureBuilder buildGridViewList(AsyncSnapshot favourites) {
    return FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            //do as intended
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 5,
                      childAspectRatio: 0.8,
                      maxCrossAxisExtent: 150,
                      crossAxisSpacing: 5),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
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
                      child: AnimatedContainer(
                        width: 250.w,
                        duration: Duration(seconds: 3),
                        curve: Curves.bounceInOut,
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
                  }),
            );
          } else {
            return Text('null');
          }
        });
  }
}
