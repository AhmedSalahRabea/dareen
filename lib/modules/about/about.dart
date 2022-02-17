// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AboutScreen extends StatelessWidget {
  static const String line1 =
      ' شركة دارين هي شركة توصيل تقوم علي خدمة قرية صفط الخمار والقري المجاورة وهي أسهل وأسرع طريقة لشراء أي متطلبات من المنزل دون زيادة في المصاريف وأسرع طريقة لطلب المشاوير بضغطة زر واحدة';
  static const String line2 =
      '1) يجب عمل الحساب برقم الهاتف الخاص لسهولة التواصل ';
  static const String line3 = '2) يمكنكم التواصل عبر الهاتف او عبر الواتساب';
  static const String line4 = '3) يجب كتابة العنوان مفصل لسهولة توصيل الطلبات';
  static const String line5 =
      '4) للإبلاغ عن أي شكوي يمكن إرسال الشكوي في رسالة عبر الواتساب علي رقم الشركة الخاص أو الاتصال بنا مباشرة';
  static const String line6 =
      '5) في حالة وجود أي إقتراح يساعد علي تطوير الخدمة وتسهيل الأمور علي أهلنا في البلد يمكن إرساله وسيتم العمل عليه فوراً';
  static const String line7 =
      '6) التطبيق غير مقيد بالمنتجات الموجودة بداخله وفي حالة إحتياجك لأي شئ يمكن التواصل معنا وسنقوم بجلبه لك بأسرع وقت ممكن';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'حول',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 16.sp),
          ),
        ),
        body: Padding(
          padding:
              EdgeInsets.only(right: 5.0.w, left: 5.w, top: 1.h, bottom: 1.h),
          child: ListView(
            children: [
              Text(
                'حول تطبيق دارين :',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: 1.h),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 15,
                      height: 1.6,
                    ),
                child: Text(
                  line1,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 12.sp,
                        height: 1.5.sp,
                      ),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'سياسة البيانات:',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: 1.h),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 12.sp,
                      height: 1.5.sp,
                    ),
                textAlign: TextAlign.start,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(line2),
                    Text(line3),
                    Text(line4),
                    Text(line5),
                    Text(line6),
                    Text(line7),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
