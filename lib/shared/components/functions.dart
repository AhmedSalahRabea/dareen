import 'package:flutter/material.dart';
import 'package:tbib_toast/tbib_toast.dart';

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
void buildToast({
  required String? message,
  required BuildContext context,
  Color color = Colors.green,
  int position = 1,
}) {
  return Toast.show(
    message ?? '',
    context,
    duration: Toast.lengthLong,
    gravity: position,
    backgroundColor: color,
    backgroundRadius: 25,
  );
}

//alert dialog loke progress indicator for any loading screen
void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
        child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
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
  required String content,
  bool isBarrierDismissible = true,
  List<Widget>? actions,
}) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.white,
    elevation: 5,
    scrollable: true,
    actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    titleTextStyle: const TextStyle(
      color: Colors.deepOrange,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    content: Text(
      content,
      textDirection: TextDirection.rtl,
      style:const TextStyle(color: Colors.black, fontSize: 16),
    ),
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
      seconds: 3,
    ),
  ));
}
