// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: Container(
                color: Colors.blue,
                height: 500.h,
                width: 600.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(child: Text('What are you looking for ?')),
                    Container(
                        child: Text(
                            'Over 10,000 animes to add to your watch list')),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
