// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
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
          ],
        ),
      ),
    );
  }
}
