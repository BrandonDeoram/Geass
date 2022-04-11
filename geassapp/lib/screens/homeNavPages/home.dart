// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Stack(
              children: [
                Container(
                  height: 900.h,
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
                          'https://mangathrill.com/wp-content/uploads/2019/12/BhknXug1280x720.png'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  "Recommended",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(160, 5, 0, 0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "See all >",
                      style: TextStyle(fontSize: 12),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
