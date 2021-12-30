// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors, avoid_print

import 'package:dareen_app/modules/login/login_screen.dart';
import 'package:dareen_app/modules/on_boarding/on_boarding_item.dart';
import 'package:dareen_app/shared/components/functions.dart';
import 'package:dareen_app/shared/widgets/my_textbutton.dart';
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
  // final bool? isOnBoardingSeen;

  // OnBoardingScreen({required this.isOnBoardingSeen});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: MyTextButton(
              text: 'تخطي',
              onpressed: () {
                // BlocProvider.of<AppCubit>(context)
                //     .onboardingSeen(isOnBoardingSeen);
                navigateTo(context: context, screen: LoginScreen());
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    OnBoardingItem(model: boarding[index]),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
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
            SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 20,
                    activeDotColor: Colors.deepOrange,
                    radius: 10,
                    dotWidth: 20,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateTo(context: context, screen: LoginScreen());
                      // BlocProvider.of<AppCubit>(context)
                      //     .onboardingSeen(isOnBoardingSeen);
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
