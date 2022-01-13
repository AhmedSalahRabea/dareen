import 'package:dareen_app/shared/widgets/contacts.dart';
import 'package:dareen_app/shared/widgets/my_ok_text.dart';
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
    actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    titleTextStyle: const TextStyle(
      color: Colors.deepOrange,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    content: Text(
      content,
      textDirection: TextDirection.rtl,
      style: const TextStyle(color: Colors.black, fontSize: 16),
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
    barrierColor: Colors.amber.withOpacity(0.5),
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

//====my bottpm sheet
void myModalBottomSheet({
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
          height: MediaQuery.of(context).size.height / 1.4,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //controller: controller,
            children: [
              Image.asset(
                'assets/images/toktok.png',
                fit: BoxFit.contain,
                width: 150,
                height: MediaQuery.of(context).size.height / 7,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'يمكنك الان طلب توكتوك بضغة زر واحدة',
                textDirection: TextDirection.rtl,
              ),
              const Directionality(
                textDirection: TextDirection.rtl,
                child: ContactsWidget(
                  whatsappString: 'اطلب توكتوك من خلال الواتساب',
                  callString: 'اتصل بنا مباشرةً لطلب التوكتوك',
                ),
              ),
              MyOkTextButtonForDailog(
                okOrCancel: 'إلغاء',
                fontSize: 20,
              ),
            ],
          ),
        );
      });
}
