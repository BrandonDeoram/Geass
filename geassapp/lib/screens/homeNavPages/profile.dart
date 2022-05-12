// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/providers/google_signin.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      final imageTemp = File(image.path);
      DataBaseService().uploadBackgroundImage(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('failed to pick image');
    }
  }

  getUserName() {
    String idk =
        Provider.of<GoogleSignInProvider>(context, listen: false).getuserName();
    print(idk);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Container(
            color: Color.fromRGBO(32, 32, 32, 100),
            height: 600.h,
            width: 2000.h,
            child: FutureBuilder(
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
                        padding: EdgeInsets.only(bottom: 0),
                        child: Container(
                          child: snapshot.data['backgroundImage'] != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 5.w, color: Colors.black)),
                                  child: Image.file(
                                    File(snapshot.data['backgroundImage']!),
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(
                                  child: IconButton(
                                      color: Colors.white,
                                      iconSize: 40,
                                      onPressed: () {
                                        pickImage();
                                      },
                                      icon: Icon(Icons.file_upload_outlined))),
                        ),
                      );
                    }
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 340, top: 170),
            child: FlatButton(
                onPressed: () {},
                child: Icon(
                  Icons.cloud_upload_outlined,
                  size: 30,
                  color: Colors.grey[400],
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 200,
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(width: 10.w, color: Colors.black)),
                height: 300.h,
                width: 300.w,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 100,
              left: 100,
            ),
            child: Center(
              child: FlatButton(
                  onPressed: () {},
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
                      padding: EdgeInsets.only(bottom: 30),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data['userName'],
                              style: Theme.of(context).textTheme.headline6,
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
    ));
  }
}

//  TextButton(
//               onPressed: () {
//                 Provider.of<GoogleSignInProvider>(context, listen: false)
//                     .logout();
//               },
//               child: Text('Logout'))
