// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/providers/google_signin.dart';
import 'package:geassapp/screens/cards/anime_card.dart';
import 'package:geassapp/screens/homeNavPages/see_all_page.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:geassapp/widgets/GetList.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future imagesFuture;
  late Future nameFuture;
  File? image;
  List<Anime> favourites = [];
  final Stream fireBaseData = DataBaseService().getAnimeList();

  Future pickImage(String type) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      final imageTemp = File(image.path);
      if (type == "backgroundImage") {
        DataBaseService().uploadBackgroundImage(image.path);
      } else {
        DataBaseService().uploadAvatarImage(image.path);
      }

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('failed to pick image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  color: Color.fromRGBO(32, 32, 32, 100),
                  height: 600.h,
                  width: 2000.h,
                  child: FutureBuilder(
                    future:
                        DataBaseService().getBackgroundImage(), // async work
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Text('Loading....');
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 0),
                              child: Container(
                                child: snapshot.data['backgroundImage'] != ""
                                    ? Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 5.w,
                                                color: Colors.black)),
                                        child: Image.file(
                                          File(
                                              snapshot.data['backgroundImage']),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Container(),
                              ),
                            );
                          }
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 340),
                  child: TextButton(
                    onPressed: () {
                      Provider.of<GoogleSignInProvider>(context, listen: false)
                          .logout();
                    },
                    child: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 340, top: 170),
                  child: FlatButton(
                      onPressed: () {
                        pickImage('backgroundImage');
                      },
                      child: Icon(
                        Icons.cloud_upload_outlined,
                        size: 30,
                        color: Colors.grey[400],
                      )),
                ),
                FutureBuilder(
                  future: DataBaseService().getBackgroundImage(), // async work
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text('Loading....');
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: 140,
                            ),
                            child: Center(
                              child: Container(
                                height: 300.h,
                                width: 300.w,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(
                                        width: 10.w, color: Colors.black)),
                                child: snapshot.data['avatarImage'] != ""
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.file(
                                          File(snapshot.data['avatarImage']!),
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                          );
                        }
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 220,
                    left: 105,
                  ),
                  child: Center(
                    child: FlatButton(
                        onPressed: () {
                          pickImage('avatarImage');
                        },
                        child: Icon(
                          Icons.add_circle_outline_sharp,
                          size: 25,
                          color: Colors.grey[400],
                        )),
                  ),
                ),
                FutureBuilder(
                  future: DataBaseService().getUserInfo(), // async work
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text('Loading....');
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else {
                          return Padding(
                            padding: EdgeInsets.only(top: 250),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data['userName'],
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    "@" + snapshot.data['userAt'],
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Favourites Shows',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4, left: 160),
                  child: TextButton(
                      onPressed: () {
                        var list = {'Favourites': 1}.entries.toList();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAll(list[0], true)));
                      },
                      child: Text(
                        'See all >',
                        style: Theme.of(context).textTheme.caption,
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: StreamBuilder(
                stream: fireBaseData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return Container(
                      height: 400.h,
                      child: GetList(snapshot: snapshot, list: "favourites"),
                    );
                  } else {
                    return Text('null');
                  }
                }),
          )
        ],
      ),
    ));
  }
}
