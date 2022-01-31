// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, avoid_print

import 'package:dareen_app/modules/login/login_screen.dart';
import 'package:dareen_app/modules/on_boarding/on_boarding_item.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/my_textbutton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  PageController boardController = PageController();

  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboarding/onboarding1.png',
      title: 'أهلا بك في تطبيق دارين',
      body: 'هذا التطبيق هو تطبيق متكامل لكل متاجر صفط الخمار',
    ),
    BoardingModel(
      image: 'assets/images/onboarding/onboarding2.png',
      title: 'قريتنا تستحق دائما الأفضل',
      body:
          'وعلشان كده كان لازم يكون في طريقة تسهل علينا وعلي أهلنا شراء جميع المنتجات بضغطة زر واحدة',
    ),
    BoardingModel(
      image: 'assets/images/onboarding/onboarding3.png',
      title: 'صفط الخمار كلها بين ايديك',
      body:
          'من خلال تطبيق دارين تقدر تطلب أي حاجة ف اي وقت ومن أكتر من مكان وتجيلك لغاية البيت في دقايق ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        // backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: MyTextButton(
              text: 'تخطي',
              fontSize: 14,
              onpressed: () async {
                navigateTo(context: context, screen: LoginScreen());
                //to subscribe to all users topic
                await FirebaseMessaging.instance.subscribeToTopic('allUsers');
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    OnBoardingItem(model: boarding[index]),
                itemCount: boarding.length,
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
              ),
            ),
            //  SizedBox(height: 0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: height / 40,
                    activeDotColor: Theme.of(context).primaryColor,
                    radius: 10,
                    dotWidth: 20,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () async {
                    if (isLast) {
                      navigateTo(context: context, screen: LoginScreen());
                      //to subscribe to all users topic
                      await FirebaseMessaging.instance
                          .subscribeToTopic('allUsers');
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 2000),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
