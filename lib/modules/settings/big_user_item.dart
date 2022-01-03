// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';

class BigUserItem extends StatelessWidget {
  double? cardRadius;
  String? userName;
  String? phoneNumber;
  String? address;
  ImageProvider userProfilePic;

  BigUserItem({
    this.cardRadius = 30,
    required this.userName,
    required this.phoneNumber,
    required this.address,
    required this.userProfilePic,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    return Container(
      height: mediaQueryHeight / 5,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius:
            BorderRadius.circular(double.parse(cardRadius!.toString())),
      ),
      child: SizedBox(
        height: mediaQueryHeight / 7,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white.withOpacity(.1),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white.withOpacity(.1),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              // color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            
                            padding: const EdgeInsets.only(right: 10),
                            child: BuildCondition(
                              condition:
                                  userName != null || phoneNumber != null,
                              builder: (context) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    userName!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    phoneNumber!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  //   const SizedBox(height: 5),
                                  // Text(
                                  //   address,
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: const TextStyle(
                                  //     color: Colors.white,
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 15,
                                  //   ),
                                  // ),
                                ],
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        // User profile
                        SizedBox(
                          height: mediaQueryHeight / 7,
                          child: CircleAvatar(
                            radius: mediaQueryHeight / 12,
                            backgroundImage: userProfilePic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
