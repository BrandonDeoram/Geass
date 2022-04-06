// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserNamePage extends StatelessWidget {
  const UserNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
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
        ],
      ),
    );
  }
}
