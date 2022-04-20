// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geassapp/models/user1.dart';
import 'package:geassapp/providers/google_signin.dart';
import 'package:geassapp/screens/home/home_page.dart';
import 'package:geassapp/services/database_service.dart';
import 'package:provider/provider.dart';

class UserNamePage extends StatelessWidget {
  final String? email;
  UserNamePage(this.email);

  TextEditingController userName = TextEditingController();
  TextEditingController atName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(
              child: Center(
                child: SizedBox(
                  height: 300.h,
                  child: const Image(
                    image: AssetImage("assets/geassSym.png"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 50, 0, 0),
              child: Text("UserName"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: SizedBox(
                  height: 200.h,
                  width: 900.w,
                  child: TextField(
                    controller: userName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        filled: true,
                        fillColor: Colors.grey[850]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 20, 0, 0),
              child: Text("@Name"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: SizedBox(
                  height: 185.h,
                  width: 900.w,
                  child: TextField(
                    controller: atName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.r),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                        filled: true,
                        fillColor: Colors.grey[850]),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    var f = email;
                    if (f != null) {
                      DataBaseService().addUser(
                          User1(userName.text, atName.text, f, [], [], [], []));
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: Icon(Icons.arrow_forward_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
