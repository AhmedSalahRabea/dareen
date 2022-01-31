// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingItem extends StatelessWidget {
  final BoardingModel model;
  const OnBoardingItem({required this.model});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(model.image),
              height: height / 2.5,
            ),
            SizedBox(height: height / 70),
            Text(
              model.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 18.sp),
            ),
            SizedBox(height: height / 70),
            Padding(
              padding: EdgeInsets.all(height / 70),
              child: Text(
                model.body,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16.sp),
              ),
            ),
            //  SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
