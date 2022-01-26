import 'package:dareen_app/shared/widgets/contacts.dart';
import 'package:dareen_app/shared/widgets/my_ok_text.dart';
import 'package:flutter/material.dart';
//import 'package:tbib_toast/tbib_toast.dart';

//this method to navigate between screens
void navigateTo({required context, required screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void navigateAndFinish({required context, required screen}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (Route<dynamic> route) => false,
  );
}

//my toast
// void buildToast({
//   required String? message,
//   required BuildContext context,
//   Color color = Colors.green,
//   int position = 1,
// }) {
//   return Toast.show(
//     message ?? '',
//     context,
//     duration: Toast.lengthLong,
//     gravity: position,
//     backgroundColor: color,
//     backgroundRadius: 25,
//   );
// }

//alert dialog loke progress indicator for any loading screen
void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
        child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    )),
  );
  showDialog(
    context: context,
    builder: (context) => alertDialog,
  );
}

//alert dialog loke progress indicator for any loading screen
void showMyAlertDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  bool isBarrierDismissible = true,
  List<Widget>? actions,
}) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.white,
    elevation: 5,
    scrollable: true,
    actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    titleTextStyle: TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    content: content,
    title: Text(
      title,
      textDirection: TextDirection.rtl,
    ),
    actions: actions,
  );
  showDialog(
    context: context,
    builder: (context) => alertDialog,
    barrierDismissible: isBarrierDismissible,
    barrierColor: Theme.of(context).primaryColor.withOpacity(.3),
  );
}

//my snackbar
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mySnackBar({
  required BuildContext context,
  required String content,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(
      seconds: 1,
    ),
  ));
}

//====my bottpm sheet for toktok
void myModalBottomSheetForToktok({
  required BuildContext context,
}) {
  showModalBottomSheet(
      context: context,
      elevation: 50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/toktok.png',
                fit: BoxFit.contain,
                width: 150,
                height: MediaQuery.of(context).size.height / 7,
              ),
              Text(
                'يمكنك الان طلب توكتوك بضغة زر واحدة',
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const Directionality(
                textDirection: TextDirection.rtl,
                child: ContactsWidget(
                  whatsappString: 'اطلب توكتوك من خلال الواتساب',
                  callString: 'اتصل بنا مباشرةً لطلب التوكتوك',
                  screenHeightDivideNumber: 18,
                ),
              ),
              const MyOkTextButtonForDailog(
                okOrCancel: 'إلغاء',
                fontSize: 20,
              ),
            ],
          ),
        );
      });
}

//====my bottpm sheet for confirm order
// void myModalBottomSheetForConfirmOrder({
//   required BuildContext context,
// }) {
//   showModalBottomSheet(
//       context: context,
//       elevation: 50,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
//       ),
//       builder: (context) {
//         return SingleChildScrollView(
//           child: Container(
//             height: MediaQuery.of(context).size.height / 1.4,
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               //controller: controller,
//               children: [
//                 Image.asset(
//                   'assets/images/toktok.png',
//                   fit: BoxFit.contain,
//                   width: 150,
//                   height: MediaQuery.of(context).size.height / 7,
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   'يمكنك الان طلب توكتوك بضغة زر واحدة',
//                   textDirection: TextDirection.rtl,
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }
